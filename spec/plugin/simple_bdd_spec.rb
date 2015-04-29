require 'spec_helper'

describe 'Vim Simple BDD' do
  specify 'Generating a simple_bdd method declaration' do
    Given 'I have a Given statement with special characters'
    When 'I run the plugin on that line'
    Then 'It changes to a method declaration'
  end

  def i_have_a_given_statement_with_special_characters
    write_file('test.rb', <<-EOF)
      Given 'I   am a *Very* Important   Person/Place/Thing'
    EOF
  end

  def i_run_the_plugin_on_that_line
    vim.edit('test.rb')
    vim.command('SimpleBDD')
    vim.write
  end

  def it_changes_to_a_method_declaration
    expect(IO.read('test.rb').strip).to eq normalize_string_indent(<<-EOF)
      def i_am_a_very_important_person_place_thing
      end
    EOF
  end
end
