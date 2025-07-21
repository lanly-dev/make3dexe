from hy3dgen.shapegen import Hunyuan3DDiTFlowMatchingPipeline
from hy3dgen.texgen import Hunyuan3DPaintPipeline

# Generate mesh from image
pipeline = Hunyuan3DDiTFlowMatchingPipeline.from_pretrained('tencent/Hunyuan3D-2', device='cuda')
mesh = pipeline(image='assets/demo.png')[0]

# Generate texture for mesh
pipeline = Hunyuan3DPaintPipeline.from_pretrained('tencent/Hunyuan3D-2', device='cuda')
mesh = pipeline(mesh, image='assets/demo.png')

# Save mesh to file (GLB format)
mesh.export('output.glb')
