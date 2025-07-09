# Tanstack Query - Open Space Backend

This is the frontend code for the Tanstack Query Open Space.
Downloading this should only be necessary if the Open Space has ended and the Heroku API no longer exists.

## Setup Instructions

### Prerequisites
- Ruby 3.2.8
- Rails 8.0.2
- PostgreSQL 14.18+
- To install Rails, I recommend following the [Official Install Ruby on Rails Guide](https://guides.rubyonrails.org/install_ruby_on_rails.html).
- To install Ruby, I recommend using a tool version manager such as [mise](https://github.com/antfu/mise) or [asdf](https://asdf-vm.com/)

### Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/brandonrq506/tanstack-query-os-fe.git
   cd tanstack-query-os-be-b
   ```

2. Install the required gems:
   ```bash
   bundle install
   ```

3. Set up the database:
   ```bash
   rails db:create
   rails db:migrate
   rails db:seed
   ```

4. Start the Rails server:
   ```bash
   rails server
   ```


### Access the application
- Server will be running on port 3000 by default.
- Make sure you have `VITE_API_URL = http://127.0.0.1:3000` in your FE `.env.local` file.
- If you have any CORS issues, ensure your FE is running on `http://localhost:5173`.
