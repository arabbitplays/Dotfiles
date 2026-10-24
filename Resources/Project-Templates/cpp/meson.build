project('{{PROJECT_NAME}}', 'cpp',
  version : '0.1.0',
  default_options : ['warning_level=3', 'cpp_std=c++23']
)

run_command('bash', './scripts/generate_meson_files.sh', 'src', 'src', check: true)

src = []
subdir('src')

executable('{{PROJECT_NAME}}',
  src,
  install : true,
)
