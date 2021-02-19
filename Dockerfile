# following the scipy-notebook dockerfile
# https://github.com/jupyter/docker-stacks/blob/master/scipy-notebook/Dockerfile

FROM jupyter/scipy-notebook as tmp_mamba

RUN conda install -c conda-forge -y \
    mamba

FROM tmp_mamba


# https://stackoverflow.com/questions/65321798/how-to-config-completer-use-jedi-to-false-in-juypter-notebook-permanently
# workaround because when setting NB_UID there's a userdel ..

RUN mkdir -p /home/jovyan/.ipython/profile_default &&\
    chmod -R 777 /home/jovyan/.ipython/ &&\
    echo 'c.Completer.use_jedi = False' > /home/jovyan/.ipython/profile_default/ipython_kernel_config.py

RUN mamba install -c conda-forge -y \
    xarray