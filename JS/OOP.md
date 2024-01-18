https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Classes
1. Inheritance looks like the same as PHP
extends, ```super()``` it is the same as ```parent::```
2. Getter, Setter
it is like __get, __set in PHP but for each property
```javascript
class ShoppingCart extends Component {
  items = [];

  set cartItems(value) {
    this.items = value;
    this.totalOutput.innerHTML = `<h2>Total: \$${this.totalAmount.toFixed(2)}</h2>`;
  }

  get totalAmount() {
    const sum = this.items.reduce(
      (prevValue, curItem) => prevValue + curItem.price,
      0
    );
    return sum;
  }

  constructor(renderHookId) {
    super(renderHookId);
  }
}
```
3. Private prop and methods.
By using # in definition and in invoking!!
```javascript
class ProductList extends Component {
  #products = []; // defenition private prop

  constructor(renderHookId) {
    super(renderHookId, false);
    this.render();
    this.fetchProducts();
  }

  fetchProducts() {
    this.#products = [  // invoking private prop
```
4. Static prop and methods - the same as PHP
5. DOM build in objects
```javascript
document.getElementsByTagName('div')[0] instanceof HTMLDivElement // => true
document.getElementsByTagName('div')[0] instanceof HTMLElement // => true
document.getElementsByTagName('div') instanceof HTMLCollection // => true
```
