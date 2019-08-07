import { Component } from 'react';

class Utility extends Component {

  static getDynamicPath() {
    const currentHost = window.location.origin;
    if (currentHost === 'http://localhost:9000') {
      return 'http://localhost:8080';
    }
    return currentHost;
  }
}

export default Utility;
