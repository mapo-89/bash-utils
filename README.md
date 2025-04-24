# 🧰 bash-utils - Global bash helper functions for projects

Welcome to `bash-utils` - a collection of reusable bash helper scripts for logging, coloring, environment variables, menus and more. Ideal for shell projects, system automation and DevOps tools. 🚀

📖 This README is also available in [🇩🇪 German](README.de.md).

## 📦 Installation

```bash
sudo git clone https://github.com/dein-nutzername/bash-utils.git /usr/local/bin/bash-utils
```

Or as a submodule in the project:

```bash
git submodule add https://github.com/dein-nutzername/bash-utils utils/bash-utils
```

### 1. use **installation script**

To install `bash-utils` quickly and easily, you can use the following installation script. This script ensures that all files end up in the right places and that the permissions are set correctly.

Execute the installation script with root privileges:

```bash
sudo bash install.sh
```

### 2. **Set environment variables**

Once you have successfully executed the script, make sure that the environment variable `BASH_UTILS_DIR` is set correctly. You can add it manually to your `~/.bashrc` or `~/.bash_profile`:

```bash
export BASH_UTILS_DIR='/usr/local/bin/bash-utils'
```

### 3. **Check the installation**

To make sure that `bash-utils` has been installed correctly, you can run the following command:

```bash
source /usr/local/bin/bash-utils/lib.sh
```

If no error message appears, the installation has been completed successfully.

### 4. **Uninstallation**
If you want to uninstall `bash-utils` again, you can use the following uninstall script:

Execute the uninstall script:

```bash
sudo bash uninstall.sh
```

### 5 **Testing the functionality**
After `bash-utils` is installed, you can test the functionality, for example by creating a small test script that uses the `log_*` functions from `logging.sh`.

Example:

```bash
#!/bin/bash
source /usr/local/bin/bash-utils/lib.sh

log_info “Installation of bash-utils successful!”
```

## 📁 structure
```
bash-utils/
├── ui/ # UI-specific scripts
│ ├── layout.sh # Functions for layout and text formatting
│ ├─── lines.sh # Functions for lines and indents
│ └─── menu.sh # Menu display and UI interaction
├── colors.sh # Color definitions (text + background)
├── env.sh # .env loader + mandatory variable check
├── lib.sh # Main library for integration (initialization)
├── logging.sh # Logging with icons + color + file
└── validators.sh # Validation functions (e.g. IP, port etc.)
```

## 🚀 Use in your project
1. include `lib.sh` at the beginning of your script:
    ```bash
    source /usr/local/bin/bash-utils/lib.sh
    ```
2. optionally: place `.env file` in the project directory
    ```ini
    # .env
    RAM_LIMIT=80
    ALERT_EMAIL=admin@example.com
    ```
3. example script with logging & variables:
    ```bash
    #!/bin/bash
    source /usr/local/bin/bash-utils/lib.sh

    require_var “ALERT_EMAIL” “Please set in the .env”

    log_info “Start RAM monitoring”
    log_success “E-mail is sent to $ALERT_EMAIL”
    ```


## 🔍 Modules in detail

### 🎨 colors.sh
Provides ANSI colors as variables:
```bash
echo -e “${GREEN}Success!${NC}”
```

### 📋 logging.sh
Provides structured logs with icons, colors & file output:
```bash
log_info “System running”
log_error “Error detected”
```

### ⚙ env.sh
Loads .env files and checks for mandatory variables:
```bash
load_env
require_var “API_KEY” “Missing key for external access”
```

### 🧩 lib.sh
Central start file, loads all other modules:
```bash
source /usr/local/bin/bash-utils/lib.sh
```

## ⚙ Configurable environment variables

| Variable | Default value | Description |
|-----------------|-----------------------------------|-----------------------------------------------|
| BASH_UTILS_DIR | /usr/local/bin/bash-utils | Base directory of the modules |
| ROOT_DIR | Project directory | Useful for .env and logs |
| LOG_FILE | $LOG_DIR/main.log | Log file for log_* functions |
| LOG_DIR | $ROOT_DIR/logs | Directory for logs |
| SKIP_ENV | false | If true, .env is not loaded |

## 🧪 Test
```bash
cd test/
bash test_logging.sh
```

## 🛡 License
MIT License - Free to use, even commercially. No guarantee.

## ✨ Ideas for the future
- 📦 Provision as .deb package
- 🧪 Test suite with Bats
- 🧠 Help functions for networks, files etc.
- 🔐 Further validators (path, JSON, network etc.)
- 🧰 Bash project generator based on bash-utils

## 🤝 Contribute
Issues, pull requests & ideas are welcome - let's build together! 🚀