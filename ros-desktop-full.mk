NAME ?= osrf/ros
VERSION ?= melodic-desktop-full-stretch
CONTAINER_NAME ?= melodic_container

.PHONY: build start_nvidia start attach clean_image clean_container

# for nvidia driver
start_nvidia:
	$(info enable nvidia gpu container......) \
	docker rmi -f ${CONTAINER_NAME}; \
	docker run -it --gpus all --env="DISPLAY" --privileged --network=host --env="QT_X11_NO_MITSHM=1" --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" --name="${CONTAINER_NAME}" ${NAME}:${VERSION}

start:
	$(info start the container......) \
	docker rmi -f ${CONTAINER_NAME}; \
	docker run -it --env="DISPLAY" --privileged --network=host --env="QT_X11_NO_MITSHM=1" --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" --name="${CONTAINER_NAME}" ${NAME}:${VERSION}

attach:
	$(info start to attach container......) \
	docker exec -it ${CONTAINER_NAME} /bin/bash
 
clean_image:
	$(info start to clean image......) \
	docker rmi -f ${NAME}:${VERSION};

clean_container:
	$(info start to clean container......) \
	docker rm -f ${CONTAINER_NAME};


