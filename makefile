jupyter-dotnet.sif: makefile image.def
	singularity build --fakeroot jupyter-dotnet.sif image.def
build: jupyter-dotnet.sif

run: build
	singularity exec --bind ./notebooks:/apps/notebooks --bind ./container_bashrc:/apps/container_bashrc jupyter-dotnet.sif /bin/bash --rcfile /apps/container_bashrc

