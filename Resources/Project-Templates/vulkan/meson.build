project('{{PROJECT_NAME}}', 'cpp',
  version : '0.1.0',
  default_options : ['warning_level=3', 'cpp_std=c++23']
)

glfw_dep    = dependency('glfw3')
vulkan_dep  = dependency('vulkan')
glm_dep     = dependency('glm')

sources = files(
  'src/main.cpp',
)

executable('{{PROJECT_NAME}}',
  sources,
  dependencies : [glfw_dep, vulkan_dep, glm_dep],
  install : true,
)
