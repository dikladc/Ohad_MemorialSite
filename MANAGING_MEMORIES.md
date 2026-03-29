# Managing Memory Submissions

## How Netlify Forms Work

When someone submits a memory through the NewMemories.html page:

1. **Submission is stored**: Netlify automatically saves it in your Netlify dashboard
2. **You get notified**: You can set up email notifications in Netlify
3. **Review submissions**: Log into Netlify → Site → Forms to see all submissions

## Viewing Submissions

1. Go to your Netlify dashboard
2. Click on your site
3. Click "Forms" in the left menu
4. You'll see all "memories" form submissions with:
   - Name
   - Email
   - Title
   - Memory text
   - Uploaded photo (if any)

## Options for Displaying Memories

### Option 1: Manual Addition (Simplest)
1. Review submission in Netlify dashboard
2. Manually add approved memories to NewMemories.html
3. Redeploy the site

### Option 2: Automatic Display (More Complex)
Use Netlify Functions to fetch and display submissions automatically. This requires:
- Netlify API access token
- JavaScript to call the function
- Filtering/approval mechanism

### Option 3: Third-Party Service (Alternative)
Use a service like:
- **Airtable** (free tier): Form + automatic gallery display
- **Google Forms + Sheets**: Collect and display
- **Formspree**: Form backend with API access

## Email Notifications

To get notified of new submissions:
1. Go to Netlify dashboard → Forms
2. Click "Form notifications"
3. Add email notification
4. You'll receive an email for each new memory submitted

## Spam Protection

The form includes:
- Honeypot field (hidden field that bots fill out)
- Netlify's built-in spam filtering

For additional protection, you can:
- Enable reCAPTCHA in Netlify dashboard (free)
- Manually review submissions before publishing

---

For questions or help, refer to [Netlify Forms documentation](https://docs.netlify.com/forms/setup/).
