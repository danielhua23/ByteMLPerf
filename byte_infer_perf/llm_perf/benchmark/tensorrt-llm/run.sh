# convert model
python3 /app/tensorrt_llm/examples/llama/convert_checkpoint.py \
    --model_dir /home/models/Mixtral-8x22B-Instruct-v0.1 \
    --output_dir ./tllm_ckpt_mixtral_tp8 \
    --dtype float16 \
    --tp_size 8
batchsize="23000 30000"
for bs in $batchsize;do
    # build engine
    trtllm-build \
        --checkpoint_dir ./tllm_ckpt_mixtral_tp8 --output_dir ./trt_engines/mixtral8x22/tp8 --max_batch_size $bs --max_input_len 2048 --max_seq_len 2176 --max_num_tokens 5120

    # benchmark engine
    python3 bench_engine.py \
	--trtllm_dir /app/tensorrt_llm/ \
        --engine_dir ./trt_engines/mixtral8x22/tp8/ \
        --model_dir /home/models/Mixtral-8x22B-Instruct-v0.1 \
        --batch_size_list $bs \
        --seq_len_list 2048
done
