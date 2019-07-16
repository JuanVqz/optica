[![Build Status](https://semaphoreci.com/api/v1/projects/b73bdec0-2d88-4ce0-aa85-91a8e559cef9/2550590/badge.svg)](https://semaphoreci.com/itox/optica)

OPTICA
======

Es un punto de venta de lentes, armazones, micas y tratamientos.

## Requisitos
  * ruby 2.6.1
  * rails 5.2.2
  * postgres
  * node 11.1.0
  * yarn 1.13.0
  * [minimagick](https://github.com/minimagick/minimagick), si usas ubuntu
    instalar ´sudo apt install imagemagick´
  * [sidekiq](https://github.com/mperham/sidekiq)
  * [redis](https://redis.io/download)

## Instalación
```sh
git clone https://github.com/JuanVqz/optica.git
cd optica
bundle install

yarn install
```

## Configuración para ejecutar la aplicación

si desea enviar correos y realizar el despliegue se deben establecer las
variables de entorno del archivo `.env.example`, de lo contrario puede omitir
este paso.

## Ejecutar la aplicación
```sh
rails db:create
rails db:migrate
rails db:seed

// iniciar dos procesos
rails serve
./bin/webpack-dev-server

// ó usar foreman
cp .env.example .env
foreman start
```

## Ejecutar las pruebas
```sh
rails db:test:load
rails db:test:prepare
rake
```

## Desplegar

### En el servidor
```sh
1.- crea el archivo manifest.json
touch /var/www/optica/shared/public/assets/manifest.json

2.- crear el archivo .rbenv-vars con el siguiente contenido:
DATABASE_URL=postgresql://usuario:contraseña@ip/base_de_datos
RAILS_MASTER_KEY=llave_maestra_aqui
SECRET_KEY_BASE=llave_secreta_aqui

la SECRET_KEY_BASE se puede generar con rails secret
```

### En local
```sh
cap production deploy:check
cap production deploy
```
