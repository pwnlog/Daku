# Windows Shortcuts Collisions

The Xbox Game Bar has a few shortcuts that this configuration uses and it may conflict with your VM guest.

# Remove/Disable Xbox Game Bar

Run PowerShell as Administrator and remove the Xbox game overlay:

```powershell
Get-AppxPackage Microsoft.XboxGamingOverlay | Remove-AppxPackage 
```

Alternatively, disable the app from running in the background.