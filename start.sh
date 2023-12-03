#!/bin/bash

cat << 'EOF'
 
    )     )                                           
 ( /(  ( /(        (            *   )              )  
 )\()) )\())       )\ )   (   ` )  /(   (       ( /(  
((_)\ ((_)\   (   (()/(  ))\   ( )(_)) ))\  (   )\()) 
__((_) _((_)  )\   ((_))/((_) (_(_()) /((_) )\ ((_)\  
\ \/ /| \| | ((_)  _| |(_))   |_   _|(_))  ((_)| |(_) 
 >  < | .` |/ _ \/ _` |/ -_)    | |  / -_)/ _| | ' \  
/_/\_\|_|\_|\___/\__,_|\___|    |_|  \___|\__| |_||_| 
                                                                           

EOF

echo -e "Waiting install dependencies and check system..."

# Install git
apt-get install -qq git -y

# Install necessary packages
for pkg in proot-distro; do
    if ! dpkg -s $pkg >/dev/null 2>&1; then
        pkg install $pkg -y
    fi
done

# Check if rust is installed
if command -v rustup &> /dev/null; then
    echo "Rust is already installed, skipping installation"
else
    echo "Installing Rust..."
    # Download and install rustup
    curl https://sh.rustup.rs -sSf | sh -s -- -y
fi

echo -e "Install and check is successfully"

# Clone the avail-light repository
if [ ! -d "avail-light" ]; then
    git clone https://github.com/availproject/avail-light.git
fi

# Change into the newly cloned directory
cd avail-light

echo -e "Checking file binary already exists"
# Check if 'avail-light-linux-amd64.tar.gz' already exists
if [ ! -f "avail-light-linux-amd64.tar.gz" ]; then
    # Download the avail-light Linux amd64 binary
    curl -LO https://github.com/availproject/avail-light/releases/download/v1.7.4/avail-light-linux-amd64.tar.gz
fi

# Check if 'avail-light-linux-amd64' already exists
if [ ! -f "avail-light-linux-amd64" ]; then
    # Decompress the downloaded file
    tar -xf avail-light-linux-amd64.tar.gz
fi
echo -e "Check done !"
echo -e "Running on goldberg network..."
# Run the avail-light binary with goldberg network
nohup ./avail-light-linux-amd64 --network goldberg
echo -e "Avail light client has been set up successfully !"
