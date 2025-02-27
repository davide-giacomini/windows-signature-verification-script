# Signature Verification Script for Windows

This repository contains a PowerShell script that verifies the signature of a .p7m file using a provided .crt file and checks whether the original file and the verified file are identical.

## Requirements

Before running the script, you need the following:

- **PowerShell 5.0 or higher** (should be pre-installed on modern Windows systems).
- **OpenSSL**: OpenSSL must be installed on your system to handle the cryptographic verification.
  - You can get OpenSSL from 2 sources:
    - Either download it from the [Official Open Source Website](https://slproweb.com/products/Win32OpenSSL.html) (but download not verified).
    - Or (my favorite) you can set in the environmental variables the `openssl.exe` version available inside the default Windows git installation under `C:\Program Files\Git\usr\bin\` (source: [stackoverflow.com/questions/50625283/how-to-install-openssl-in-windows-10](https://stackoverflow.com/questions/50625283/how-to-install-openssl-in-windows-10))
- **PS2EXE (optional)**: To convert the PowerShell script to an .exe file for easier execution.

## Getting Started

### 1. Clone the Repository

First, clone the repository to your local machine:

```bash
git clone https://github.com/davide-giacomini/signature-verification-script.git
cd signature-verification-script
```

### 2. Set Up OpenSSL

Ensure that OpenSSL is installed and available in your system's PATH environment variable. You can verify if OpenSSL is correctly installed by running the following in a PowerShell terminal:

```powershell
openssl version
```

If the OpenSSL command is not recognized, you will need to add it to your system's PATH by following these steps:

- Download and install OpenSSL for Windows.
- Add the OpenSSL parent directory (where openssl.exe is located) to the PATH environment variable.

### 3. Run the Script

To use the script, you need to provide the following parameters:

- **inputFile**: Path to the original file (could be .xlsx, .docx, etc.).
- **p7mFile**: Path to the .p7m signed file.
- **crtFile**: Path to the .crt file containing the signing certificate.

You can run the script in PowerShell as follows:

```powershell
.\verify-signature.ps1 -inputFile "C:\path\to\inputFile.xlsx" -p7mFile "C:\path\to\file.p7m" -crtFile "C:\path\to\certificate.crt"
```

If everything is set up correctly, the script will output whether the signature verification was successful and if the original file and the verified file match.

### 4. Optional: Convert to .exe

If you want to convert the PowerShell script into a standalone .exe file, follow these steps:

1. **Install PS2EXE**:
   PS2EXE is a PowerShell module that can convert your PowerShell script into an executable file. Open PowerShell as Administrator and run the following:

   ```powershell
   Install-Module -Name ps2exe -Force -AllowClobber
   ```

2. **Convert the Script to .exe**:
   After installing PS2EXE, run the following command to convert the PowerShell script into an executable file:

   ```powershell
   Invoke-PS2EXE .\verify-signature.ps1 .\verify-signature.exe
   ```

3. **Move the .exe to a Directory in your PATH**:
   To make the .exe file executable from anywhere in your system, move the .exe file to a directory that is included in your PATH, or manually add the directory to your PATH environment variable.

   For example, you can move the .exe file to C:\Windows\System32 or another directory already in your PATH.

   Alternatively, add the directory where the .exe is located to the PATH variable by following these steps:
   
   - Right-click on **This PC** > **Properties**.
   - Click on **Advanced system settings**.
   - Click **Environment Variables**.
   - Under **System variables**, select **Path** and click **Edit**.
   - Add the directory containing erify-signature.exe to the list and click **OK**.

4. **Run the .exe File**:
   Now, you can run the .exe from any command prompt without needing to specify the full path:

   ```bash
   verify-signature.exe -inputFile "C:\path\to\inputFile.xlsx" -p7mFile "C:\path\to\file.p7m" -crtFile "C:\path\to\certificate.crt"
   ```

### 5. Verify the Signature

When you run the script or .exe, the following will happen:

1. It will verify the signature of the .p7m file using the certificate (.crt file).
2. It will then compare the original file with the verified file.
3. If both the verification and the comparison are successful, a success message will be shown.
4. If either verification fails or the files differ, an error message will be shown.

---

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

### Notes:
- If you're planning to distribute or use the .exe, make sure the necessary dependencies (such as OpenSSL) are installed and accessible on the user's system.
- This script and .exe are intended for signature verification in scenarios where file integrity and authenticity need to be confirmed.

