# Zoomify Gem

Wrapper for [Zoom](https://zoom.github.io/api/) API V2

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'zoomify'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install zoomify

## Usage

Initialize Zoom client in your app

    client = Zoomify::Client.new(api_key: 'your_api_key', api_secret: 'your_api_secret')

#### Accounts

List all sub accounts

    accounts = client.accounts
    
Additional parameters can be passed as

    accounts = client.accounts(page_size: 5, page_number: 3)

Create a sub account (params can be found [here](https://zoom.github.io/api/#create-a-sub-account))

    account = client.accounts_create(params)

Retrieve a sub account

    account = client.account(id: 'account id')
    
Disassociate an account

    account = client.accounts_delete(id: 'account id')
    
Update a sub account's options (params can be found [here](https://zoom.github.io/api/#update-a-sub-accounts-options))

    account = client.accounts_update_options(id: 'account id', share_rc: true, share_mc: true)
    
Retrieve a sub account's settings

    account = client.accounts_settings(id: 'account id')
    
Update a sub account's settings (params can be found [here](https://zoom.github.io/api/#update-a-sub-accounts-settings))
    
    account = client.accounts_settings_update(id: 'account id', schedule_meting: {host_video: true})
    
#### Billing

Retrieve billing information for a sub account

    billing = client.billing(id: 'account id')
    
Update billing information for a sub account (params can be found [here](https://zoom.github.io/api/#update-billing-information-for-a-sub-account))

    billing = client.billing_update(id: 'account id', first_name: 'John Doe')
    
Retrieve plan information for a sub account

    plan = client.plan(id: 'account id')
    
Subscribe plans for a sub account (params can be found [here](https://zoom.github.io/api/#subscribe-plans-for-a-sub-account))

    plan = client.plan_subscribe(id: 'account id', contact: {first_name: 'John Doe'})

Update a plan base for a sub account (params can be found [here](https://zoom.github.io/api/#update-a-base-plan-for-a-sub-account))

    plan_base = client.update_base_plan(id: 'account id', type: 'string', hosts: 1)
    
Add an additional plan for a sub account (params can be found [here](https://zoom.github.io/api/#add-an-additional-plan-for-sub-account))

    addon = client.create_addon(id: 'account id', type: 'string', hosts: 1)
    
Update an additional plan for a sub account (params can be found [here](https://zoom.github.io/api/#update-an-additional-plan-for-sub-account))

    addon = client.update_addon(id: 'account id', type: 'string', hosts: 1)
    
#### Users

List Users (optional params can be found here [here](https://zoom.github.io/api/#list-users))

    users = client.users

Create a user (params can be found here [here](https://zoom.github.io/api/#create-a-user))

    user = client.user_create(params)
    
Retrieve a user (params can be found here [here](https://zoom.github.io/api/#retrieve-a-user))

    user = client.user(id: 'user id')
    
Update a user (params can be found here [here](https://zoom.github.io/api/#update-a-user))

    user = client.user_update(id: 'user id', first_name: 'John Doe')
    
Delete a user (optional params can be found [here](https://zoom.github.io/api/#delete-a-user))

    user = client.user_delete(id: 'user id')
    
List a  user's assistants

    assistants = client.user_assistants(id: 'user id')
    
Add assistants (params can be found [here](https://zoom.github.io/api/#add-assistants))

    assistant = client.user_assistants_create(id: 'user id', assistants: [{id: 'string', email: 'string'}])
    
Delete all assistants of a user

    assistant = client.user_assistants_delete_all(id: 'user id')
    
Delete a user's assistant

    assistant = client.user_assistant_delete(id: 'user id', assistant_id: 'assistant id')
    
List a user's schedulers

    schedulers = client.user_schedulers(id: 'user id')
    
Delete all schedulers of a users

    schedulers = client.user_schedulers_delete_all(id: 'user id')
    
Delete a user's scheduler
    
    scheduler = client.user_schedulers_delete(id: 'user id', scheduler_id: 'scheduler id')
    
Upload a user's picture (information about params can be found [here](https://developer.zoom.us/playground/#/Users/userPicture))

    picture = client.upload_picture(id: 'user id', pic_file: 'file')
    
Retrieve a user's settings

    settings = client.user_settings(id: 'user id')
    
Update a user's settings (params can be found [here](https://zoom.github.io/api/#update-a-users-settings))
    
    settings = client.user_settings_update(id: 'user id', scheduled_meeting: { host_video: true })
    
Update a user's status (params can be found [here](https://zoom.github.io/api/#update-a-users-status))

    status = client.user_status_update(id: 'user id', action: 'active')

Update a user's password (params can be found [here](https://zoom.github.io/api/#update-a-users-password))

    password = client.user_password_update(id: 'user id', password: 'ABCXYZ')
    
Retrieve a user's permissions

    permissions = client.user_permissions(id: 'user id')
    
Retrieve a user's token (optional params can be found [here](https://zoom.github.io/api/#retrieve-a-users-token))

    token = client.user_token(id: 'user id')
    
Revoke a user's SSO Token

    token = client.user_token_delete(id: 'user id')
    
Verify a user's zpk (Deprecated)

    zpk = client.verify_zpk(zpk: 'User zpk')
    
Verify a user's email

    email = client.verify_email(email: 'User email')
    
Check a user's personal meeting room name

    vanity_name = client.verify_vanity_name(vanity_name: 'User Vanity Name')
    
#### Meetings

List meetings (optional params can be found [here](https://zoom.github.io/api/#list-meetings))

    meetings = client.meetings(id: 'user id')
    
Create a meeting (params can be found [here](https://zoom.github.io/api/#create-a-meeting))

    meeting = client.meetings_create(id: 'user_id', topic: 'Zoomify Gem')
    
Retrieve a meeting

    meeting = client.meeting(id: 'meeting id')
    
Update a meeting (params can be found [here](https://zoom.github.io/api/#update-a-meeting))
    
    meeting = client.meeting_update(id: 'meeting id', topic: 'Zoomify Gem')
    
Delete a meeting (optional params can be found [here](https://zoom.github.io/api/#delete-a-meeting))

    meeting = client.meeting_delete(id: 'meeting id')
    
Update a meeting's status (params can be found [here](https://zoom.github.io/api/#update-a-meetings-status))

    status = client.meeting_update_status(id: 'meeting id', action: 'end')
    
List a meeting's registrants (optional params can be found [here](https://zoom.github.io/api/#list-a-meetings-registrants))

    registrants = client.meeting_registrants(id: 'meeting id')
    
Add a meeting registrant (params can be found [here](https://zoom.github.io/api/#add-a-meeting-registrant))

    registrant = client.meeting_registrants_create(id: 'meeting id', email: 'johndoe@email.com', first_name: 'John', last_name: 'Doe')

Update a meeting registrant's status (params can be found [here](https://zoom.github.io/api/#update-a-meeting-registrants-status))

    status = client.meeting_registrants_update_status(id: 'meeting id', action: 'approve')
    
Retrieve past meeting details

    past_meeting = client.past_meeting(uuid: 'meeting uuid')
    
Retrieve past meeting participants (optional params can be found [here](https://zoom.github.io/api/#retrieve-past-meeting-participants))

    participants = client.past_meeting_participants(uuid: 'meeting uuid')
    
#### Webinars

List webinars (optional params can be found [here](https://zoom.github.io/api/#list-webinars))

    webinars = client.webinars(id: 'user id')
    
Create a webinar (params can be found [here](https://zoom.github.io/api/#create-a-webinar))

    webinar = client.webinar_create(id: 'user_id', topic: 'Zoomify Gem')
    
Retrieve a webinar

    webinar = client.webinar(id: 'webinar id')
    
Update a webinar (params can be found [here](https://zoom.github.io/api/#update-a-webinar))

    webinar = client.webinar_update(id: 'webinar id', topic: 'Zoomify Gem')
    
Delete a webinar (optional params can be found [here](https://zoom.github.io/api/#delete-a-webinar))

    webinar = client.webinar_delete(id: 'webinar id')
    
Update a webinar's status (params can be found [here](https://zoom.github.io/api/#update-a-webinars-status))

    status = client.webinar_update_status(id: 'webinar id', status: 'end')
    
List a webinar's panelists

    panelists = client.webinar_panelists(id: 'webinar id')
    
Add a webinar penelist (params can be found [here](https://zoom.github.io/api/#add-a-webinar-panelist))

    panelist = client.webinar_panelists_create(id: 'webinar id', panelists: [{name: 'string', email: string}])
    
Remove all panelists from webinar

    panelists = client.webinar_panelists_delete_all(id: 'webinar id')
    
Remove a webinar panelist

    panelist = client.webinar_panelists_delete(id: 'webinar id', panelist_id: 'panelist id')
    
List a webinar's registrants (optional params can be found [here](https://zoom.github.io/api/#list-a-webinars-registrants))
    
    registrants = client.webinar_registrants(id: 'webinar id') 
    
Add a webinar registrant (params can be found [here](https://zoom.github.io/api/#add-a-webinar-registrant))

    registrant = client.webinar_registrants_create(id: 'webinar_id', email: 'johndoe@email.com', first_name: 'John', last_name: 'Doe')
    
Update a webinar registrant's status (params can be found [here](https://zoom.github.io/api/#update-a-webinar-registrants-status))

    status = client.webinar_registrants_update_status(id: 'webinar id', action: 'approve')
 
List of ended webinar instances
    
    webinars = client.past_webinars(id: 'webinar id')
    
#### Groups

List groups

    groups = client.groups
    
Create a group

    group = client.groups_create(name: 'string')
    
Retrieve a group

    group = client.group(id: 'group id')
    
Update a group

    group = client.group_update(id: 'group id', name: 'string')
    
Delete a group

    group = client.group_delete(id: 'group id')
    
List a group's members (optional params can be found [here](https://zoom.github.io/api/#list-a-groups-members))

    members = client.group_members(id: 'group id')
    
Add group members (params can be found [here](https://zoom.github.io/api/#add-group-members))

    members = client.group_members_create(id: 'group id', members: [{id: 'string', email: 'string'}])
    
Delete a group member

    member = client.group_delete_member(id: 'group id', member_id: 'member id')
    
#### IM Groups

List IM Groups
    
    im_groups = client.im_groups
    
Create an IM Group (params can be found [here](https://zoom.github.io/api/#create-an-im-group))

    im_group = client.im_groups_create(params)
    
Retrieve an IM Group

    im_group = client.im_group(id: 'group id')
    
Update an IM Group (params can be found [here](https://zoom.github.io/api/#update-an-im-group))

    im_group = client.im_group_update(id: 'group id', name: 'Zoomify Gem')
    
Delete an IM Group

    im_group = client.im_group_delete(id: 'group id')
    
List an IM Group Members (optional params can be found [here](https://zoom.github.io/api/#list-an-im-groups-members))

    members = client.im_group_members(id: 'group id')
    
Add IM Group members (params can be found [here](https://zoom.github.io/api/#add-im-group-members))

    members = client.im_group_members_create(id: 'group id', members: [{id: 'string', email: 'string'}])
    
Delete an IM Group Member

    member = client.im_group_delete_member(id: 'group id', member_id: 'member id')
    
#### IM Chat

Retrieve IM Chat Sessions (optional params can be found [here](https://zoom.github.io/api/#retrieve-im-chat-sessions))

    im_chat_session = client.im_chat_sessions(from: 'Start date', to: 'End date')
    
Retrieve IM Chat Messages (optional params can be found [here](https://zoom.github.io/api/#retrieve-im-chat-messages))

    im_chat_messages = client.im_chat_session_messages(id: 'session id', from: 'Start date', to: 'End date')
    
#### Cloud Recording

List all the recordings (optional params can be found [here](https://zoom.github.io/api/#list-all-the-recordings))

    recordings = client.user_cloud_recordings(id: 'user id', from: 'Start date', to: 'End date')
    
Retrieve all recordings of a meeting

    recordings = client.meeting_cloud_recordings(id: 'meeting id')
    
Delete all recordings of a meeting (params can be found [here](https://zoom.github.io/api/#delete-a-meetings-recordings))

    recordings = client.meeting_cloud_recordings_delete_all(id: 'meeting id', action: 'trash') 
    
Delete particular recording of a meeting (optional params can be found [here](https://zoom.github.io/api/#delete-one-meeting-recording-file))

    recording = client.meeting_cloud_recording_delete(id: 'meeting id', recording_id: 'recording id')
    
Recover all recordings of a meeting (params can be found [here](https://zoom.github.io/api/#recover-a-meetings-recordings))

    recordings = client.meeting_cloud_recordings_recover(id: 'meeting id', action: 'recover')
    
Recover a single recording file (params can be found [here](https://zoom.github.io/api/#recover-a-single-recording))

    recording = client.meeting_cloud_recording_recover(id: 'meeting id', recording_id: 'recording id', action: 'recover')
    
#### Reports

Retrieve daily report (optional params can be found [here](https://zoom.github.io/api/#retrieve-daily-report))

    report = client.daily_report
    
Retrieve hosts report (optional params can be found [here](https://zoom.github.io/api/#retrieve-hosts-report))

    report = client.users_report(from: 'Start date', to: 'End date')
    
Retrieve meetings report (optional params can be found [here](https://zoom.github.io/api/#retrieve-meetings-report))

    report = client.meetings_report(id: 'user id', from: 'Start date', to: 'End date')
    
Retrieve meeting details report

    report = client.meeting_details_report(id: 'meeting id')
    
Retrieve meeting participants report (optional params can be found [here](https://zoom.github.io/api/#retrieve-meeting-participants-report))

    report = client.meeting_participants_report(id: 'meeting id')
    
Retrieve meeting polls report

    report = client.meeting_polls_report(id: 'meeting id')
    
Retrieve webinar details report

    report = client.webinar_daily_report(id: 'webinar id')
    
Retrieve webinar participants report (optional params can be found [here](https://zoom.github.io/api/#retrieve-webinar-participants-report))

    report = client.webinar_participants_report(id: 'webinar id')
    
Retrieve webinar polls report

    report = client.webinar_polls_report(id: 'webinar id')
    
Retrieve webinar Q&A report

    report = client.webinar_qa_report(id: 'webinar id')
    
Retrieve Telephone report (optional params can be found [here](https://zoom.github.io/api/#retrieve-telephone-report))

    report = client.telephone_report(from: 'Start date', to: 'End date')
    
#### Dashboards

List meetings (optional params can be found [here](https://zoom.github.io/api/#list-meetings126))

    metrics = client.meeting_metrics(from: 'Start date', to: 'End date')
    
Retrieve meeting details (optional params can be found [here](https://zoom.github.io/api/#retrieve-meeting-detail))

    metrics = client.meeting_detail_metrics(id: 'meeting id')
    
Retrieve meeting participants (optional params can be found [here](https://zoom.github.io/api/#retrieve-meeting-participants))

    metrics = client.meeting_participants_metrics(id: 'meeting id')
    
Retrieve meeting participant QOS (optional params can be found [here](https://zoom.github.io/api/#retrieve-meeting-participant-qos))

    metrics = client.particular_meeting_participant_qos_metrics(id: 'meeting id', participant_id: 'participant id')
    
List meeting participants QOS (optional params can be found [here](https://zoom.github.io/api/#list-meeting-participants-qos))

    metrics = client.meeting_participants_qos_metrics(id: 'meeting id')
    
Retrieve sharing/recording details of meeting participants (optional params can be found [here](https://zoom.github.io/api/#retrieve-sharing-recording-details-of-meeting-participant))
    
    metrics = client.meeting_participants_sharing_metrics(id: 'meeting id')
    
List webinars (optional params can be found [here](https://zoom.github.io/api/#list-webinars132))

    metrics = client.webinar_metrics(from: 'Start date', to: 'End date')
    
Retrieve webinar details (optional params can be found [here](https://zoom.github.io/api/#retrieve-webinar-detail))

    metrics = client.webinar_details_metrics(id: 'webinar id')
    
Retrieve webinar participants (optional params can be found [here](https://zoom.github.io/api/#retrieve-webinar-participants))

    metrics = client.webinar_participants_metrics(id: 'webinar id')
    
Retrieve webinar participant QOS (optional params can be found [here](https://zoom.github.io/api/#retrieve-webinar-participant-qos))

    metrics = client.particular_webinar_participant_qos_metrics(id: 'webinar id', participant_id: 'participant id')
    
List webinar participants QOS (optional params can be found [here](https://zoom.github.io/api/#list-webinar-participant-qos))

    metrics = client.webinar_participants_qos_metrics(id: 'webinar id')
    
Retrieve sharing/recording details of Webinar participants (optional params can be found [here](https://zoom.github.io/api/#retrieve-sharing-recording-details-of-webinar-participant))
    
    metrics = client.webinar_participants_sharing_metrics(id: 'webinar id')
    
List Zoom Rooms (optional params can be found [here](https://zoom.github.io/api/#list-zoom-rooms))

    metrics = client.zoom_rooms_metrics
    
Retrieve Zoom Room (optional params can be found [here](https://zoom.github.io/api/#retrieve-zoom-room))
    
    metrics = client.retrieve_zoom_room(id: 'zoom room id', from: 'Start date', to: 'End date')
    
Retrieve CRC Port Usage

    metrics = client.crc_metrics(from: 'Start date', to: 'End date')
    
Retrieve IM (optional params can be found [here](https://zoom.github.io/api/#retrieve-im))

    metrics = client.im_metrics(from: 'Start date', to: 'End date')
    
#### Webhooks

Switch webhook version

    webhook = client.webhook_options(version: 'v1')
    
List webhooks

    webhook = client.webhooks
    
Create a webhook (params can be found [here](https://zoom.github.io/api/#create-a-webhook))

    webhook = client.webhooks_create(params)
    
Retrieve a webhook

    webhook = client.webhook(id: 'webhook id')
    
Update a webhook (params can be found [here](https://zoom.github.io/api/#update-a-webhook))

    webhook = client.webhook_update(id: 'webhook id', url: 'string')
    
Delete a webhook

    webhook = client.webhook_delete(id: 'webhook id')
    
#### TSP

List TSP dial-in numbers

    tsp = client.dial_in_numbers
    
List user's TSP accounts

    tsp = tsp_accounts(id: 'user id')
    
Add a user's TSP account (params can be found [here](https://zoom.github.io/api/#add-a-users-tsp-account))

    tsp = client.tsp_accounts_create(id: 'user id', conference_code: 'string')    
    
Retrieve a user's TSP account

    tsp = client.user_tsp_account(id: 'user id', tsp_id: 'TSP id')
    
Update a TSP account (params can be found [here](https://zoom.github.io/api/#update-a-tsp-account))

    tsp = client.user_tsp_account_update(Id: 'user id', tsp_id: 'TSP id', conference_code: 'string')

Delete a user's TSP account

    tsp = client.user_tsp_account_delete(id: 'user id', tsp_id: 'TSP id')

#### PAC

List user's PAC accounts

    pac = client.pac_accounts(id: 'user id')
    
#### Devices

List H.323/SIP Devices

    devices = client.devices
    
Create a H.323/SIP Devices (params can be found [here](https://zoom.github.io/api/#create-a-h-323-sip-device))

    device = client.devices_create(params) 
    
Update a H.323/SIP Device (params can be found [here](https://zoom.github.io/api/#update-a-h-323-sip-device))

    device = client.device_update(id: 'device id', name: 'string')
 
Delete a H.323/SIP Device

    device = client.device_delete(id: 'device id')

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/fakhir-shad/zoomify. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).