# PowerShell script to install Hunyuan3D-2 with all dependencies
# Run this from the make3dexe directory with virtual environment activated

Write-Host "Installing Hunyuan3D-2 dependencies..." -ForegroundColor Green

# Activate virtual environment
& ".venv\Scripts\activate"

# Navigate to Hunyuan3D-2 directory
Set-Location "Hunyuan3D-2"

Write-Host "Installing requirements.txt..." -ForegroundColor Yellow
pip install -r requirements.txt

Write-Host "Installing CUDA version of PyTorch..." -ForegroundColor Yellow
pip uninstall torch torchvision -y
pip install torch torchvision --index-url https://download.pytorch.org/whl/cu121

Write-Host "Installing package in editable mode..." -ForegroundColor Yellow
pip install -e .

Write-Host "Installing texture generation components..." -ForegroundColor Yellow

# Set CUDA_HOME environment variable for CUDA extensions
$env:CUDA_HOME = "C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v12.1"
Write-Host "Setting CUDA_HOME to: $env:CUDA_HOME" -ForegroundColor Cyan

# Install custom_rasterizer
Write-Host "Installing custom_rasterizer..." -ForegroundColor Cyan
Set-Location "hy3dgen\texgen\custom_rasterizer"
python setup.py install
Set-Location "..\..\..\"

# Install differentiable_renderer
Write-Host "Installing differentiable_renderer..." -ForegroundColor Cyan
Set-Location "hy3dgen\texgen\differentiable_renderer"
python setup.py install
Set-Location "..\..\..\"

Write-Host "Installation completed!" -ForegroundColor Green
Write-Host "You can now run your Hunyuan3D scripts." -ForegroundColor Green
