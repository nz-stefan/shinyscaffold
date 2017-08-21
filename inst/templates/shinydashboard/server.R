###########################################################
# Global server logic of the application
#
# Author: {{author}}
# Created: {{creation_date}}
###########################################################


shinyServer(
  function(input, output, session) {

    # call modules to add functionality of dashboard tabs
    {{#modules}}
    callModule({{value.id}}Module, "{{value.id}}_module")
    {{/modules}}

    # handle help messages
    observeEvent(input$intro, {
      {{#modules}}
      if (input$tabs == "{{value.id}}") {
        rintrojs::introjs(session, options = list(
          steps = {{value.id}}ModuleHelp("{{value.id}}_module")
        ))
      }
      {{/modules}}
    })
  }
)
