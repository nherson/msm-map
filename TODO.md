# TODO

* ~~Add pagination to google queries~~
* ~~POC map view~~
* ~~Cron job to keep the app alive~~
* ~~Setup workflow to access the site locally from mobile (ngrok?)~~
* ~~Fix geo links~~
* ~~DNS for map.venturapop.org~~
* ~~TailwindCSS install~~
* ~~Cron job to keep Redis up to date~~
* ~~Phone viewbox~~
* Some sort of filter/exclusion/override/injection system for google data
  * ~~Filter bullshit businesses~~
  * Inject businesses that don't show up for whatever reason
  * ~~Rules to rename businesses with odd formatting, etc.~~
  * ~~Trim unused fields (class for `Business`)~~
* Tests
* Change cache to hold mashalled `Business` sets after post-processing 
* ~~Refactor `Places::Business` to `Map::Place`~~
* Tagging system to support custom categorization
  * Categories
    * Beer
    * Cocktails
    * Lunch
    * Dinner
    * Nightlife
    * Thrifting and Anitiques
    * Art
    * Coffee
    * Gifts and Decor
    * Home Goods
    * Tourist (pier, botanical garden, city hall, museum, mission, promenade, surfer's point)
  * Google's assigned categories are pretty... not great. Curation may be a must.
  * Migrate the google "types" into `lib/clients` and use our own defined types
    * These should simply inform the base set of places we fetch and cache, as a pre-filter
* Suggested activities/business workflow from home page
* FAQ and links
* Revisit pipelining places through filter/transform/etc, maybe a single per-place override system is best