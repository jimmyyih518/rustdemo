import torch
import torch.nn as nn


# Define a simple model
class SimpleModel(nn.Module):
    def __init__(self):
        super(SimpleModel, self).__init__()
        self.fc = nn.Linear(2, 1)  # 2 inputs, 1 output

    def forward(self, x):
        if isinstance(x, tuple):
            x = x[0]
        return torch.sigmoid(self.fc(x))


if __name__ == "main":
    # Create an instance of the model
    model = SimpleModel()

    # Save the model's state dict for use later
    scripted_model = torch.jit.script(model)  # Convert to TorchScript
    scripted_model.save("../simple_model.pt")

    # Alternatively, trace the state dict for simple models
    # input_tensor = torch.tensor([[0.5, -1.2]], dtype=torch.float32)
    # traced_model = torch.jit.trace(model, input_tensor)  # Convert to TorchScript
    # traced_model.save("../simple_model.pt")
