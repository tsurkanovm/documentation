```typescript
// Primitives: number, string, boolean
// More complex types: arrays, objects
// Function types, parameters

let age: number;

age = 12;

let userName: string | string[];

userName = 'Max';

// More complex types

let hobbies: string[];

hobbies = ['Sports', 'Cooking'];

type Person = { // we can create own types (alias) and use them in our type defenitions
  name: string;
  age: number;
};

let person: Person;

person = {
  name: 'Max',
  age: 32,
};

// person = {
//   isEmployee: true
// };

let people: Person[];

// Type inference - when we initiate variable and set value we can sckip type def it will get it from the value

let course = 'React - The Complete Guide';

course = 12341; // will return error

// Functions & types
function print(value: any) : void
{
  console.log(value);
}

// Generics
function insertAtBeginning<T>(array: T[], value: T) { // function can get any type of array, 
    // but with generics - we declare that array and value should be the same type (own type T) and ts infer it and will treat as array of specific type
  const newArray = [value, ...array];
  return newArray;
}

const demoArray = [1, 2, 3];

const updatedArray = insertAtBeginning(demoArray, -1); // [-1, 1, 2, 3]
const stringArray = insertAtBeginning(['a', 'b', 'c'], 'd')

updatedArray[0].split(''); // will be error, but without generics in ok cause array of any type

let numbers: Array<number> = [1, 2, 3]; // it is the same as let numbers:number[] = [1, 2, 3]; but here generic is build-in type
```