import React, { Component } from 'react';
import { Jumbotron, Media, Button } from 'reactstrap';
import img from './assets/picture-error-dialog.png';

export default class ErrorBoundary extends Component {
  constructor(props) {
    super(props);

    this.state = {
      error: null,
      errorInfo: null
    };
  }

  componentDidCatch(error, info) {
    console.error(error);

    this.setState({
      error: error,
      errorInfo: info
    });
  }

  render() {
    if (this.state.error) {
      return (
        <div className="error-boundary m-5 p-5">
          <Jumbotron fluid className="rounded p-5">
            <Media>
              <Media left className="mr-5">
                <img src={img} alt="" />
              </Media>
              <Media body>
                <h1 className="display-5">Something's not quite right.</h1>
                <p className="lead">There's been an error in the application.</p>
                <hr className="my-2" />
                <p>And here is some information to send to the developers.</p>
                <details className="mb-3" style={{whiteSpace: 'pre-wrap'}}>
                  {this.state.error && this.state.error.toString()}
                  {this.state.errorInfo.componentStack}
                </details>
                <p className="lead">
                  <a href="/" data-test="error page" data-category="ErrorBoundary" data-action="go dashboard">
                    <Button color="primary">Go back home</Button>
                  </a>
                </p>
              </Media>
            </Media>
          </Jumbotron>
        </div>
      );
    }
    return this.props.children;
  }
}
