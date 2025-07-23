

@echo off
REM Create Python virtual environment
python -m venv .venv
if exist .venv\Scripts\activate.bat (
    call .venv\Scripts\activate.bat
) else (
    echo Failed to create or find virtual environment activation script.
    exit /b 1
)

REM Upgrade pip
python -m pip install --upgrade pip

REM Install PyTorch and dependencies
python -m pip install torch torchvision --index-url https://download.pytorch.org/whl/cu121 torchaudio --index-url https://download.pytorch.org/whl/cu121


REM Install numpy 1.26 explicitly
python -m pip install numpy==1.26.*


REM Create temp file in root dir
copy Hunyuan3D-2.1\requirements.txt requirements_tmp.txt >nul
REM Comment out deepspeed in requirements_tmp.txt to avoid version conflict - no need for deepspeed
powershell -Command "(Get-Content requirements_tmp.txt) -replace '^(deepspeed[<>=!~0-9., ]*)','# $1' | Set-Content requirements_tmp.txt"
REM Comment out bpy==4.0 in requirements_tmp.txt to avoid invalid version error
powershell -Command "(Get-Content requirements_tmp.txt) -replace '^(bpy==4.0)','# $1' | Set-Content requirements_tmp.txt"

REM Install compatible versions to resolve dependency conflicts
python -m pip install "numpy==1.26.4"
python -m pip install "transformers==4.48.0"
python -m pip install "bpy==4.2.0"

REM Install other requirements (using modified requirements file in root dir)
python -m pip install -r requirements_tmp.txt

REM Install custom rasterizer (editable mode)
cd Hunyuan3D-2.1\hy3dpaint\custom_rasterizer
REM Ensure torch is available for building
python -c "import torch; print('Torch available for building')"
REM Ensure wheel is installed for building
python -m pip install wheel
python -m pip install -e . --no-build-isolation --verbose
cd ..\..

REM Add hy3dpaint directory to Python path for textureGenPipeline module
cd Hunyuan3D-2.1\hy3dpaint
python -c "import sys; sys.path.append('.'); import textureGenPipeline; print('textureGenPipeline module available')"
cd ..\..

REM Compile DifferentiableRenderer (requires bash, so manual step for Windows)
cd Hunyuan3D-2.1\hy3dpaint\DifferentiableRenderer
echo Please run compile_mesh_painter.sh manually in a bash shell (e.g., Git Bash)
cd ..\..

REM Download RealESRGAN_x4plus.pth
if not exist Hunyuan3D-2.1\hy3dpaint\ckpt mkdir Hunyuan3D-2.1\hy3dpaint\ckpt
curl -L -o Hunyuan3D-2.1\hy3dpaint\ckpt\RealESRGAN_x4plus.pth https://github.com/xinntao/Real-ESRGAN/releases/download/v0.1.0/RealESRGAN_x4plus.pth

echo Installation steps completed. Please check for any errors above.
