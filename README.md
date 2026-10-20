# AidMitra Student Planner — MVP 3.8 Student-ready edition

This version hides the technical Supabase URL/key fields from students and uses the configured public project settings automatically. Students only need to sign in or create an account. It also fixes a configuration issue where blank settings saved by an older version could override the app defaults, and bumps the service-worker cache so devices can receive the updated app.

## Publish to the existing GitHub Pages repository

1. Extract this ZIP.
2. Open https://github.com/aidmitra/aidmitra-student-planner
3. Choose **Add file → Upload files**.
4. Upload the six files in this folder to the repository root, replacing the existing files.
5. Commit the changes to `main` and wait for GitHub Pages to deploy.
6. Open https://aidmitra.github.io/aidmitra-student-planner/ and refresh. If a device still shows the old page, close the tab and reopen the site, or clear the site's cached data.

## Owner checklist before inviting students

- Confirm `supabase_schema.sql` has been run in the correct Supabase project's SQL Editor.
- Keep Row Level Security enabled and verify that each signed-in user can access only their own planner record.
- Test account creation, sign-in, password recovery/confirmation settings, and sync on two devices.
- Supabase email rate limits can block repeated signup/confirmation emails. Configure a reliable SMTP provider for a public launch and avoid repeated signup attempts during testing.
- The client-side key in this build is a **publishable** key. Never put a Supabase `service_role` or secret key in website code or a public repository.

This build simplifies setup but does not itself certify the project's database policies or auth settings. Test with two separate accounts before a public rollout.
