```
python -m venv .venv
.venv\Scripts\activate
```

### Troubleshooting
>We now require users to upgrade torch to at least v2.6 in order to use the function --> Downgrade `transformer` to 4.49

>ImportError: DLL load failed while importing custom_rasterizer_kernel: The specified procedure could not be found. --> go rebuild `hy3dgen/texgen/custom_rasterizer`
> ```sh
  python setup.py clean
  python setup.py install
  ```

### Versions
- CUDA 12.6
- torch 2.7.1
