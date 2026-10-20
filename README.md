# AidMitra Student Planner — MVP 2.0

A mobile-first student organiser with timetable management, assignments, exam countdowns, smart study suggestions, timetable import, calendar import, and reminder settings.

## Quick start

**Recommended (for service worker / PWA support):**
1. Extract this ZIP.
2. Install a current version of Node.js if you do not already have it.
3. In this folder, run `npx serve .` (or use another local static HTTP server).
4. Open the local URL printed by the server in Chrome.
5. On Android Chrome, use **⋮ → Add to Home screen** to install the PWA.

You can also open `index.html` directly for most core features, but service worker/offline shell and some browser capabilities require HTTP/HTTPS.

## MVP 3.0 features

- Email/password student accounts using Supabase Auth.
- Optional cloud sync of planner data between devices, with row-level security (RLS).
- First sync merges records from the current device and cloud by item ID; subsequent syncs push the current local planner.
- Local-only mode remains available if no Supabase project is configured.

## MVP 2.0 features

- Responsive dashboard, weekly timetable, assignment tracker, exam countdown, study suggestions.
- Add/remove classes, tasks, and exams.
- Timetable import from CSV; import from text-based PDF; OCR for timetable images and scanned first-page PDFs using Tesseract.js and PDF.js loaded from CDNs.
- Import `.ics` calendar events into the timetable.
- Google Calendar read-only import, if you configure your own Google OAuth Client ID and enable the Google Calendar API.
- Smart reminders for classes, upcoming/overdue assignments, and exams (7, 3, 1 days and exam day).
- Reminder preferences and test notification.
- JSON backup export/import.
- Basic PWA manifest, app icon, service worker shell cache.
- Data persists in local browser storage.

## CSV import format

Recommended header row:
`Subject,Day,Start,End,Room,Teacher`

Example:
`Pharmacology,Monday,09:00,10:00,Block A,Dr Smith`

Time formats such as `09:00`, `9:00 AM`, and `2:30 PM` are supported. Review every extracted row before importing; OCR may misread text.

## Google Calendar setup

Google Calendar integration is optional and uses the student's own Google Cloud project:
1. Open Google Cloud Console and create/select a project.
2. Enable **Google Calendar API**.
3. Configure the OAuth consent screen and create an OAuth Client ID of type **Web application**.
4. Add your local/deployed app origin (for example `http://localhost:3000`) to **Authorised JavaScript origins**.
5. Paste the Client ID in AidMitra Settings → Calendar import / Google Calendar.
6. Select **Connect Google Calendar** and grant read-only calendar access.

This implementation imports timed events from the primary calendar for the next 90 days. It is a one-time import, not continuous two-way synchronisation. Events are imported into AidMitra's class list. It skips all-day events. For a production release, configure OAuth consent/verification as applicable and implement token lifecycle handling, event deduplication/update/deletion, recurring class logic, and a secure backend if needed.

## Notification limitations (important)

- The app asks for browser notification permission and checks for reminders every 30 seconds while the page/app is running.
- A service worker is included for PWA shell caching and notification-click handling, but it does **not** itself schedule alarms.
- Browser JavaScript timers cannot reliably run when the app is closed or the phone suspends it. Reliable background alerts require a push backend plus service-worker push subscription, or native Android local-notification scheduling (for example Capacitor + a local notifications plugin).
- Keep the app open for this MVP's scheduled reminder checks. Test notifications need notification permission and HTTPS/localhost in most browsers.

## Data and privacy

- Data is stored locally in the browser's `localStorage`. It is not backed up to a server or synced across devices.
- Google Calendar access is read-only and granted by the student through Google sign-in. Only event information returned by the Calendar API is imported.
- The OCR/PDF parser libraries load from public CDNs when needed; the selected file is processed in the browser. No AidMitra backend is used in this prototype.
- Do not enter sensitive personal information in this MVP.

## Suggested next production phase

1. Add authentication and a secure cloud database for cross-device sync.
2. Add server/native background reminders and user-configurable quiet hours.
3. Improve timetable extraction using a column-aware parser and import preview with course/time conflict detection.
4. Add recurring weekly class rules, semester dates, holidays, and rescheduling.
5. Add Android package, automated tests, error reporting, and accessibility testing.


## Cloud sync setup (Supabase)

1. Create a project at Supabase.
2. Open **SQL Editor** and run `supabase_schema.sql` from this project.
3. In Supabase project settings, copy the project URL and the public anon/publishable key.
4. In AidMitra Settings → Cloud sync & student account, paste the URL and public key, then select **Save configuration**.
5. Create an account using email/password. If email confirmation is enabled, confirm the email first and then sign in.
6. Use **Sync now** to sync the current planner. Once signed in, edits trigger a best-effort sync after a short debounce.

### Cloud sync limitations
- This is an MVP sync model, not a production conflict-resolution system. First sign-in merges records by item ID. After that, the local planner is treated as the working copy and pushed to the cloud. For reliable multi-device concurrent edits, add per-record timestamps, tombstones for deletions, conflict UI, and server-side transactional merge.
- Sync is initiated from the open app; it is not a background sync service.
- The Supabase URL and public anon/publishable key are stored in browser local storage. This is expected for client apps; Row Level Security must be enabled exactly as in `supabase_schema.sql`.
- Do not use the Supabase `service_role` key in the browser.
- Authentication emails and password policy are controlled by your Supabase project.


## Email confirmation redirect fix (MVP 3.1)

The signup flow now explicitly redirects email confirmation to the current app path, including the GitHub Pages repository subfolder. For the hosted version, open `https://aidmitra.github.io/aidmitra-student-planner/` before creating an account; do not create the account from `localhost`. In Supabase Authentication → URL Configuration, set Site URL to `https://aidmitra.github.io/aidmitra-student-planner/` and add that same exact URL under Redirect URLs. Save changes, then create/resend a fresh confirmation email. Old confirmation links can expire or retain an old redirect target.
