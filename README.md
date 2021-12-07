### Pre-requisitos

#### Docker

- MacOS

  ```
  Descargar e instalar: https://download.docker.com/mac/stable/Docker.dmg
  ```

- Linux

  ```shell
  curl -sSL https://get.docker.com/ | sh
  sudo usermod -aG docker $(whoami)
  curl -L "https://github.com/docker/compose/releases/download/1.11.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  chmod +x /usr/local/bin/docker-compose
  ```

  NOTA:

  Se deberá reiniciar o salirse de la sesión para poder tomar los cambios

#### Cmake

- MacOS

  ```shell
  brew install cmake
  ```

- Linux

  ```shell
  apt-get install cmake
  ```

## Inicializacion del proyecto

1. En la raíz del proyecto, ejecuta el comando

   ```shell
   make bootstrap
   ```
   
2. Posterior a esto, para levantar el contenedor del proyecto, deberas ejecutar el comando:

  ```shell
  make phx.logs
  ```
  
 Esto levantara una instancia del proyecto en docker mostrandote en la terminal los logs del sistemna.
