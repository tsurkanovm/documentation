
```js
componentDidMount() { //the same as useEffect without dependencies - run once after component was mount and rendered
    // Send http request...
    this.setState({ filteredUsers: DUMMY_USERS });
  }

  componentDidUpdate(prevProps, prevState) { //the same as useEffect with searchTerm as dep
    if (prevState.searchTerm !== this.state.searchTerm) {
      this.setState({
        filteredUsers: DUMMY_USERS.filter((user) =>
          user.name.includes(this.state.searchTerm)
        ),
      });
    }
  }

componentWillUnmount() //  the same as useEffect without dependencie that return function (clean-up) - invoke once right before componet will be unmounted 

componentDidCatch(error) { // error boundaties - there is no analogy in func style, invoke when child component throw an error
    console.log(error);
    this.setState({ hasError: true });
}
```