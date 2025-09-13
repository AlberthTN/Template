FROM python:3.10-slim

# Establecer directorio de trabajo
WORKDIR /app

# Instalar dependencias del sistema
RUN apt-get update && apt-get install -y \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Copiar archivos de requerimientos
COPY requirements.txt .

# Instalar dependencias de Python
RUN pip install --no-cache-dir -r requirements.txt

# Copiar el archivo .env primero
COPY .env .env

# Copiar el resto del código de la aplicación
COPY . .

# Crear directorio para logs
RUN mkdir -p /app/logs

# Variables de entorno por defecto
ENV PORT=3000
ENV PYTHONUNBUFFERED=1
ENV PYTHONPATH=/app
ENV TZ=America/Mexico_City

# Asegurar que los archivos tengan los permisos correctos
RUN chmod +x main.py
RUN chmod 600 .env

# Exponer el puerto
EXPOSE ${PORT}

# Comando para ejecutar la aplicación
CMD ["python", "main.py"]