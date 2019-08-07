import React from 'react';
import { MemoryRouter } from 'react-router-dom';
import { mount } from 'enzyme';
import Hello from '../../src/components/Hello';

describe('something', () => {
  let enzymeWrapper;

  beforeEach(() => {
    enzymeWrapper = mount(
        <MemoryRouter initialEntries={['/test']} initialIndex={1}>
          <Hello />
        </MemoryRouter>
    );
  });

  afterEach(() => {
    enzymeWrapper.unmount();
  });

  test('should display Hello component', () => {
    expect(enzymeWrapper.find('div').at(0)).toHaveText('No message from server');
  });

});
