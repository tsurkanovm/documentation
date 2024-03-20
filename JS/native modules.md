script type=module - sign that we can use export/import keywords
```javascript
<script src="assets/scripts/app.js" defer type="module"></script>
```
CORS policy error will show up when we use file protocol and we want to import module script. Needs to use adummy server
```text
npm list -g - all packages

sudo npm install -g serve
then just run serve on project folder - it will look for index.html and run server for it (provide the address - localhost::5000 for example)
```

you can export const, vars, func and classes
```javascript
export function doSomething() {};

import { DOMHelper } from '../Utility/DOMHelper.js';

export class ProjectItem {
```
PHP analogy - the export like a "public" in php (except classes - that always can be use), import like a "use" or even - require (but 3 syntax for import - path and what specificly we import in {}, or "* as " - and we get all exports available, or just Alias for default export statement)
```javascript
import { ProjectItem as PrjItem } from './ProjectItem.js'; // or just {ProjectItem}
import * as DOMH from '../Utility/DOMHelper.js'; // everything with export in DOMHelper.js will be available like DOMH.
```
```javascript
// Component file:
export function doSomething() {};
export default class { // default, should be only one in a file export 
    
}

// file we we import Component file
import Cmp, { doSomething } from './Component.js'; // Cmp is default so we can provide own name
```

import(file).then() - it is like PHP proxy - will load file only when it invokes

```javascript
// export/import should the first line in a file
// import will load file imidiatelly and invoke the code of this file that out of scope (func or obj)
// next snipped will import and load Tooltip.js only when this part will invoked
import('./Tooltip.js').then(module => {
      const tooltip = new module.Tooltip(
        () => {
          this.hasActiveTooltip = false;
        },
        tooltipText,
        this.id
      );
      tooltip.attach();
      this.hasActiveTooltip = true;
    });
```
globalThis - for browser - window but it will work for nodejs where window is not exist. It is current global object.
we have module scope the same as function or object. If you need to share data needs to use globalThis (or window) or export/import variable across modules