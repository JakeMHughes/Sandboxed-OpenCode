docker build -t lmstudio .


docker save lmstudio:latest > lmstudio.tar

microk8s ctr image import lmstudio.tar