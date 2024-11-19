from flask import Flask, request, jsonify
import psycopg2
import bcrypt

app = Flask(__name__)

# Configuración de la base de datos PostgreSQL
def get_db_connection():
    conn = psycopg2.connect(
        dbname="database",  # Nombre de tu base de datos
        user="postgres",     # Nombre del usuario de PostgreSQL
        password="root",  # Tu contraseña de PostgreSQL
        host="localhost",
        port="5432"
    )
    return conn



# Ruta para registrar un nuevo usuario
@app.route('/register', methods=['POST'])
def register_user():

    conn = get_db_connection()
    cursor = conn.cursor()
    
    # SQL para crear la tabla 'users' si no existe
    cursor.execute("""
        CREATE TABLE IF NOT EXISTS users (
            id SERIAL PRIMARY KEY,
            username VARCHAR(50) UNIQUE NOT NULL,
            password_hash TEXT NOT NULL
        )
    """)
    
    conn.commit()
    cursor.close()
    conn.close()

    data = request.get_json()
    username = data['username']
    password = data['password']

    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM users WHERE username = %s", (username,))
    existing_user = cursor.fetchone()

    if existing_user:
        return jsonify({"message": "El usuario ya existe"}), 400

    password_hash = bcrypt.hashpw(password.encode('utf-8'), bcrypt.gensalt()).decode('utf-8')
    cursor.execute(
        "INSERT INTO users (username, password_hash) VALUES (%s, %s)", 
        (username, password_hash)
    )
    conn.commit()

    cursor.close()
    conn.close()

    return jsonify({"message": "Usuario registrado correctamente"}), 201

# Ruta para autenticar al usuario
@app.route('/login', methods=['POST'])
def login_user():
    data = request.get_json()  # Obtener los datos en formato JSON
    username = data['username']
    password = data['password']

    # Verificar si el usuario existe
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT password_hash FROM users WHERE username = %s", (username,))
    user = cursor.fetchone()

    cursor.close()
    conn.close()

    # Verificar si se encontró el usuario y validar la contraseña
    if user and bcrypt.checkpw(password.encode('utf-8'), user[0].encode('utf-8')):
        return jsonify({"message": "Inicio de sesión exitoso"}), 200
    else:
        return jsonify({"message": "Usuario o contraseña incorrectos"}), 400
# Ruta para obtener la lista de usuarios
@app.route('/users', methods=['GET'])
def get_users():
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT id, username FROM users")
    users = cursor.fetchall()
    cursor.close()
    conn.close()

    user_list = [{"id": user[0], "username": user[1]} for user in users]
    return jsonify({"users": user_list}), 200

# Ruta para eliminar un usuario
@app.route('/users/<int:user_id>', methods=['DELETE'])
def delete_user(user_id):
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("DELETE FROM users WHERE id = %s", (user_id,))
    conn.commit()
    cursor.close()
    conn.close()

    return jsonify({"message": "Usuario eliminado correctamente"}), 200

# Ruta para actualizar un usuario
@app.route('/users/<int:user_id>', methods=['PUT'])
def update_user(user_id):
    data = request.get_json()
    new_username = data.get('username')
    new_password = data.get('password')

    conn = get_db_connection()
    cursor = conn.cursor()

    # Actualizar solo si se proporcionan nuevos valores
    if new_username:
        cursor.execute("UPDATE users SET username = %s WHERE id = %s", (new_username, user_id))
    
    if new_password:
        new_password_hash = bcrypt.hashpw(new_password.encode('utf-8'), bcrypt.gensalt())
        cursor.execute("UPDATE users SET password_hash = %s WHERE id = %s", (new_password_hash, user_id))
    
    conn.commit()
    cursor.close()
    conn.close()

    return jsonify({"message": "Usuario actualizado correctamente"}), 200

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)
