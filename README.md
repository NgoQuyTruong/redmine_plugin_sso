# Redmine VarealID Plugin
**What does the plugin will do?**
* Single Sign-On with Vareal ID System
* List all services of user assigned on common header
**Install**
* Clone code:
  ```
  git clone git@github.com:vareal/redmine-google-calendar.git
  ```
* Rename folder from redmine-vareal-id to redmine_vareal_id
* Copy redmine_vareal_id plugin to {RAILS_APP}/plugins on your redmine path.
* Bundle gem:
    ```
    bundle install
    ```
**Uninstall**
* Remove redmine_vareal_id plugin in {RAILS_APP}/plugins

**How to set up this plugin after installation**
1. Setup
  * Set SERVICE_ID, CLIENT_ID, VAREAL_ID_BASE_URL variable in init.rb
  * Example
    ```
      'SERVICE_ID' => '5434f14dd04535e382d5',
      'CLIENT_ID' => 'b7e339053580dfb2d49b',
      'VAREAL_ID_BASE_URL' => 'http://localhost:3001'
    ```
2. Required
   * you must be in an VarealID organization
   * You will be assigned to the services of that organization
3. How to use ?
  * Click login with vareal_id in login page
  * You can see (common header) icon on top-right of header include list services you're assigned
  * You can click any service you want -> auto login this service
**Other information**

Plugin development based on:
* Redmine 5.0
* ruby '>= 2.5.0', '< 3.2.0'
* rails '6.1.6'
