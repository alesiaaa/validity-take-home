import React, { Component } from 'react';
import { getHelloMessage } from "../actions/helloAction";

class Hello extends Component {
  constructor(props) {
    super(props);
    this.state = {
      message: 'No message from server'
    };
  }

  componentDidMount() {
    this._isMounted = true;
    getHelloMessage().then(message => {
      if (this._isMounted)
        this.setState({message});
    }).catch(() => {
      if (this._isMounted)
        this.setState({message: 'The server did not respond so...hello from the client!'});
    });
  }

  componentWillUnmount() {
    this._isMounted = false;
  }

  render() {
    return (
      <div>{this.state.message}</div>
    );
  }
}

export default Hello;
