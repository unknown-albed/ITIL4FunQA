# 🚀 Release Guide - ITIL® 4 Foundation Quiz App

## 📋 **Understanding GitHub Actions Workflows**

### **🔄 Workflow Triggers:**

#### **1. Build & Release Workflow (`build-and-release.yml`)**
```yaml
Triggers:
- Push to main branch: ✅ Builds APK, ❌ Skips release
- Push version tag (v*): ✅ Builds APK, ✅ Creates release
- Pull requests: ✅ Builds APK, ❌ Skips release
```

#### **2. Web Deployment Workflow (`deploy-web.yml`)**
```yaml
Triggers:
- Push to main branch: ✅ Deploys to GitHub Pages
- Manual trigger: ✅ Deploys to GitHub Pages
```

---

## 🎯 **Creating Releases**

### **Method 1: Command Line (Recommended)**

#### **Step 1: Create and Push Tag**
```bash
# Create annotated tag with release notes
git tag -a v1.2.0 -m "🚀 Release v1.2.0: Your release description

✨ New Features:
- Feature 1
- Feature 2

🔧 Bug Fixes:
- Fix 1
- Fix 2

📱 Platforms: Android APK, Web App, iOS (build from source)"

# Push the tag to trigger release
git push origin v1.2.0
```

#### **Step 2: Monitor Workflow**
1. Visit: https://github.com/unknown-albed/ITIL4FunQA/actions
2. Look for "Build and Release APK" workflow
3. Both "build" and "release" jobs should run
4. Release will be created automatically with APK

### **Method 2: GitHub Web Interface**

#### **Step 1: Create Release**
1. Go to: https://github.com/unknown-albed/ITIL4FunQA/releases
2. Click "Create a new release"
3. Click "Choose a tag" → Type new tag (e.g., `v1.2.0`) → "Create new tag"
4. Fill in release title and description
5. Click "Publish release"

#### **Step 2: Workflow Triggers**
- Publishing the release will trigger the workflow
- APK will be built and attached to the release

---

## 📝 **Version Numbering**

### **Semantic Versioning (Recommended)**
```
v1.2.3
│ │ │
│ │ └── Patch: Bug fixes, small improvements
│ └──── Minor: New features, backward compatible
└────── Major: Breaking changes, major updates
```

### **Examples:**
- `v1.0.0` - Initial stable release
- `v1.1.0` - Added new quiz features
- `v1.1.1` - Fixed bugs in quiz logic
- `v2.0.0` - Major UI overhaul

---

## 🔍 **Current Release Status**

### **Latest Release: v1.1.0**
- **Status**: ✅ Created successfully
- **APK**: Available for download
- **Web App**: https://unknown-albed.github.io/ITIL4FunQA/
- **Release Page**: https://github.com/unknown-albed/ITIL4FunQA/releases/latest

### **What's Included:**
- **Android APK**: `app-release.apk` (direct download)
- **Release Notes**: Comprehensive feature list
- **Installation Guide**: Links to documentation
- **System Requirements**: Android 5.0+ (API 21)

---

## 🛠️ **Workflow Troubleshooting**

### **❌ "Create Release" Job Skipped**
**Cause**: Pushed to main branch without version tag
**Solution**: Create and push a version tag (see Method 1 above)

### **❌ APK Build Fails**
**Cause**: Code compilation errors or missing dependencies
**Solution**: 
1. Check workflow logs in Actions tab
2. Fix compilation errors locally
3. Test with `flutter build apk --release`
4. Push fixes and create new tag

### **❌ Release Creation Fails**
**Cause**: Permission issues or duplicate tag
**Solution**:
1. Ensure repository has proper permissions
2. Use unique version tag
3. Check if tag already exists: `git tag -l`

---

## 📊 **Release Automation**

### **What Happens Automatically:**
1. **Code Analysis**: `flutter analyze` checks code quality
2. **Testing**: Runs all unit tests
3. **APK Build**: Compiles release APK for Android
4. **Release Creation**: Creates GitHub release with:
   - Professional release notes
   - APK attachment for download
   - Installation instructions
   - System requirements
   - Links to web app and guides

### **Manual Steps (Optional):**
1. **Update Version**: Update `pubspec.yaml` version before tagging
2. **Changelog**: Update CHANGELOG.md with release notes
3. **Documentation**: Update README if needed
4. **Testing**: Test APK on physical devices

---

## 🎯 **Quick Release Commands**

### **Patch Release (Bug Fixes)**
```bash
git tag -a v1.1.1 -m "🔧 Bug fix release v1.1.1"
git push origin v1.1.1
```

### **Minor Release (New Features)**
```bash
git tag -a v1.2.0 -m "✨ Feature release v1.2.0"
git push origin v1.2.0
```

### **Major Release (Breaking Changes)**
```bash
git tag -a v2.0.0 -m "🚀 Major release v2.0.0"
git push origin v2.0.0
```

---

## 📱 **Distribution**

### **Android Users:**
- **Direct Download**: GitHub Releases page
- **Installation**: Enable "Unknown Sources" and install APK
- **Updates**: Manual download of new releases

### **Web Users:**
- **Access**: https://unknown-albed.github.io/ITIL4FunQA/
- **Updates**: Automatic (deployed on every push to main)
- **PWA**: Can install as native app

### **iOS Users:**
- **Build Guide**: [iOS_BUILD_GUIDE.md](iOS_BUILD_GUIDE.md)
- **Requirements**: macOS + Xcode + Apple Developer Account
- **Updates**: Manual rebuild from source

---

## 🔗 **Useful Links**

- **Repository**: https://github.com/unknown-albed/ITIL4FunQA
- **Releases**: https://github.com/unknown-albed/ITIL4FunQA/releases
- **Actions**: https://github.com/unknown-albed/ITIL4FunQA/actions
- **Web App**: https://unknown-albed.github.io/ITIL4FunQA/
- **Issues**: https://github.com/unknown-albed/ITIL4FunQA/issues

---

**🎯 Remember: Version tags (v*) trigger both APK builds AND release creation. Regular pushes to main only build APKs for testing.**