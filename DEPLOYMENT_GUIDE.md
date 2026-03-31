# Deployment Guide - Memorial Website

## Prerequisites

1. A personal GitHub account (free)
2. A Netlify account (free) - sign up at https://netlify.com

## Step 1: Create GitHub Repository

Since you want to use your **personal GitHub account** (not your work account):

1. Open a web browser and log into your **personal GitHub account**
2. Go to: https://github.com/new
3. Fill in the repository details:
   - **Repository name**: `ohad-memorial-site` (or any name you prefer)
   - **Description**: "Memorial website for Ohad Dotan"
   - **Visibility**: Choose **Private** or **Public** (your choice)
   - **DO NOT** initialize with README, .gitignore, or license (we already have these)
4. Click "Create repository"
5. You'll see a page with instructions. **Copy the URL** that looks like:
   ```
   https://github.com/YOUR-USERNAME/ohad-memorial-site.git
   ```

## Step 2: Push Code to GitHub

1. Open Command Prompt or PowerShell
2. Navigate to the site directory:
   ```
   cd C:\Users\dikladc\Downloads\OhadSite-New
   ```
3. Add your GitHub repository as the remote:
   ```
   git remote add origin https://github.com/YOUR-USERNAME/ohad-memorial-site.git
   ```
   (Replace `YOUR-USERNAME` with your actual GitHub username)

4. Push the code:
   ```
   git branch -M main
   git push -u origin main
   ```

5. If prompted, enter your GitHub credentials:
   - **Username**: Your GitHub username
   - **Password**: Use a **Personal Access Token** (not your password)
     - To create a token: GitHub → Settings → Developer settings → Personal access tokens → Generate new token
     - Select scope: `repo` (full control of private repositories)
     - Copy the token and use it as your password

## Step 3: Deploy to Netlify

1. Go to https://app.netlify.com and sign up/login
2. Click "Add new site" → "Import an existing project"
3. Choose "Deploy with GitHub"
4. Authorize Netlify to access your GitHub account
5. Select your repository: `ohad-memorial-site`
6. Configure build settings:
   - **Branch to deploy**: `main`
   - **Build command**: (leave empty)
   - **Publish directory**: `.` (or leave empty)
7. Click "Deploy site"

## Step 4: Configure Custom Domain (Optional)

If you want to use a custom domain (like ohadotan.com):

1. In Netlify dashboard → Site settings → Domain management
2. Click "Add custom domain"
3. Enter your domain name
4. Follow Netlify's instructions to configure DNS settings in your domain registrar (e.g., GoDaddy)

## Step 5: Set Up Form Notifications

To receive email when someone submits a memory:

1. In Netlify dashboard → Forms → Form notifications
2. Click "Add notification"
3. Choose "Email notification"
4. Enter your email address
5. Save

## Step 6: Enable reCAPTCHA (Optional - Better Spam Protection)

1. In Netlify dashboard → Site settings → Forms
2. Scroll to "Form detection"
3. Enable reCAPTCHA
4. Follow the instructions to set up Google reCAPTCHA
5. Update `NewMemories.html` to add:
   ```html
   data-netlify-recaptcha="true"
   ```
   to the form tag

## Testing the Site

After deployment:

1. Visit your Netlify URL (e.g., `https://random-name-12345.netlify.app`)
2. Test the new memories form: `/NewMemories.html`
3. Submit a test memory to ensure forms are working
4. Check Netlify dashboard → Forms to see the submission

## Managing Submissions

See `MANAGING_MEMORIES.md` for details on:
- Viewing submissions
- Moderating content
- Displaying memories on the site

## Updating the Site

To make changes:

1. Edit files in `C:\Users\dikladc\Downloads\OhadSite-New`
2. Commit and push:
   ```
   git add .
   git commit -m "Description of changes"
   git push
   ```
3. Netlify will automatically rebuild and redeploy (takes ~1 minute)

## Migrating from GoDaddy

Once the new site is live and tested:

1. Update your domain's DNS to point to Netlify (see Step 4)
2. Wait for DNS propagation (can take up to 48 hours)
3. Cancel your GoDaddy hosting (keep the domain if you want to use it)

## Need Help?

- **Netlify Documentation**: https://docs.netlify.com
- **GitHub Documentation**: https://docs.github.com
- **Netlify Support**: support@netlify.com

---

**Note**: The site is already initialized as a git repository and has an initial commit. You just need to push it to GitHub and deploy to Netlify.
