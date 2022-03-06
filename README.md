TARM - The Awesome Resource Manager



Upcoming Features:
 - Signal output for all remaining resources
 - Overview of total resources left




How it works

 - Every resource entity is stored in `Global.resourceTracker.trackedResources` as an unordered table/object
 - On `OnLoad` a positionCache is created by using `Object.entries` which is looped over with all trackedResources
