FROM redis:6.2.6

# Copiar el archivo de configuración de Redis
COPY ./redis.conf /usr/local/etc/redis/redis.conf

# Comando para iniciar Redis con el archivo de configuración
CMD ["redis-server", "/usr/local/etc/redis/redis.conf"]