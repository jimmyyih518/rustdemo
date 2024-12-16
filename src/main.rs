use tch::{Tensor, Kind};

fn main() -> Result<(), Box<dyn std::error::Error>> {
    // Load the TorchScript model
    let model = tch::CModule::load("simple_model.pt")?;
    println!("Model loaded successfully!");

    // Example input (batch of size 1 with 2 features)
    let input = Tensor::of_slice(&[0.5, -1.2])
        .to_kind(Kind::Float)
        .reshape(&[1, 2]);

    // Run the model
    let output = model.forward_ts(&[input])?;

    // Print the prediction
    println!("Model output: {:?}", output);

    Ok(())
}
