- PB - Page Builder
- add link that generates from php - `{{store url = 'digits''}}
- but we can generate URL for existing pages - specific PDP, Pages, categories - from constructor
- blocks, widgets can be add from constructor (buttons)
- variables and custom variables also available (the same ad for email templates), you can it from constructor or just use `{{config path="general/store_information/hours"}}`
- Dynamic Blocks - only EE functionality. Uses Customer Segment as condition to show content (also powered by PB). 
- Segments have powerful condition functionality- you can use customer attributes, shopping cart, order history
As example we can create segment - man/women (or after 1000$ of purchases) and shows different blocks for them
- And this functional works with FPC (that unique only for – store_id, currency_id, customer_group_id combinations). 
So Home page with dynamic blocks can have different content for both customers with equal customer_group_id (it is like private content but on BE side)  