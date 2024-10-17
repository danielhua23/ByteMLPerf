# TensorRT-LLM Benchmark


## benchmark env
Follwing envs have been tested:
- Docker image: tensorrt_llm/release:v0.13.0
- TensorRT-LLM: 0.13.0
- TensorRT: 10.4.0.26

## How to run
### launch docker container
you can check the "tensorrt_llm/release:v0.13.0" image is availiable or not by ```docker images```, if it is, you can skip the 1st step, or you must execute the below cmd first.
### 1.How to build trtllm:0.13.0 image (Oct-17)

notice: directly pip wheel install will miss `cpp/bench` binaries, the following is required to compile `cpp/bench` in docker first.

```sh
git clone -b v0.13.0 --recursive  https://github.com/NVIDIA/TensorRT-LLM.git

cd TensorRT-LLM
# on H20/H100
make -C docker release_build CUDA_ARCH="90-real"
# until now, the benchmark binary has been built successfully.
```
### 2.launch container
note: need change the "/path/to/home" and "/path/to/models" to your work dir and model dir on your machine
```sh
docker run --net=host --pid=host --ipc=host --privileged -it --gpus all -v /path/to/home/:/home/ -v /path/to/models:/home/models --name container_name tensorrt_llm/release:v0.13.0
```
### 3.Run
before run, ensure your model is under the dir "/home/models/", your compiled tensorrt_llm named "/app/tensorrt_llm" exists.
```sh
cd home
git clone https://github.com/danielhua23/ByteMLPerf.git
cd ByteMLPerf/byte_infer_perf/llm_perf/benchmark/tensorrt-llm
bash run.sh
``` 
