```graphql
enum MythEnum {
    GREEK
    EGYPTIAN
    CHINESE
    NORSE
    CELTIC
    BABYLONIAN
}

enum DomainEnum {
    THUNDER
    SUN
    WAR
    LOVE
    WISDOM
}

enum HeightUnitEnum {
    INCH
    FOOT
    METER
}
type God {
    id: ID!
    name: String!
    domain: DomainEnum
    mythology: MythEnum!
}

type PageInfo {
    currentPage: Int!,
    totalPages: Int!
}

type AllGodsPage {
    pageInfo: PageInfo,
    gods: [God!]!
}

type Food {
    id: ID!
    label: String!
    cuisine: String
}
type Person {
    id: ID!
    name: String!
    height(unit: HeightUnitEnum = INCH): Float
    favoriteFoods(limit: Int = 10): [Food!]!
    friends: [Person!]!
    createdAt: String!
}

type Query {
    person(id: ID!): Person
    allGods(domain: DomainEnum, page: Int, limit: Int): AllGodsPage
}
input PersonInput {
    name: String!
    height: Float
}

type Mutation {
    createPerson(
        person: PersonInput!,
        favoriteFoodIds: [ID],
        friendIds: [ID]
    ): Person
}
```
Query:
```graphql
{
    person(
        id: "12345"
    ) {
        name
        height(unit: INCH)
        favoriteFoods(limit: 2) {
            label
            cuisine
        }
    }

    allGods(
        domain: THUNDER,
        page: 1
        limit: 3
    ) {
        pageInfo {
            currentPage
            totalPages
        }
        gods {
            name
            mythology
        }
    }
}
```
Mutation:
```graphql
mutation doCreatePerson(
#    When non-scalar types are available for field arguments, their definitions are separate from the usual object types returned from queries
    $person: PersonInput!, #The ! character suffixing PersonInput indicates the variable is required
    # [] indicate an array of that type rather than a single value.
    $favoriteFoodIds: [ID], 
    $friendIds: [ID]
) {
    createPerson(
        person: $person,
        favoriteFoodIds: $favoriteFoodIds,
        friendIds: $friendIds
    ) {
        id
        name
        createdAt
    }
}
#variables:
{
"person": {
"name": "Sally",
"height": 68
},
"favoriteFoodIds": [
"123",
"456"
],
"friendIds": [
"789"
]
}
```