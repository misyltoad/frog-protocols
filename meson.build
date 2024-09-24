project('frog-protocols',
	'c',
	version: '0.01',
	meson_version: '>= 0.55.0',
	license: 'MIT/Expat',
)

frog_protocols_version = meson.project_version()

fs = import('fs')

frog_protocols = {
    'frog-color-management': ['v1'],
    'frog-fifo': ['v1'],
}

protocol_files = []

foreach name, versions : frog_protocols
	foreach version : versions
		if version == ''
			protocol_files += ['frog-protocols/@0@.xml'.format(name)]
		else
			protocol_files += ['frog-protocols/@0@-@1@.xml'.format(name, version)]
		endif
	endforeach
endforeach

foreach protocol_file : protocol_files
	protocol_install_dir = fs.parent(join_paths(
		get_option('datadir'),
		protocol_file,
	))
	install_data(
		protocol_file,
		install_dir: protocol_install_dir,
	)
endforeach

frog_protocols_srcdir = meson.current_source_dir()

pkgconfig_configuration = configuration_data()
pkgconfig_configuration.set('prefix', get_option('prefix'))
pkgconfig_configuration.set('datarootdir', '${prefix}/@0@'.format(get_option('datadir')))
pkgconfig_configuration.set('abs_top_srcdir', frog_protocols_srcdir)
pkgconfig_configuration.set('PACKAGE', 'frog-protocols')
pkgconfig_configuration.set('FROG_PROTOCOLS_VERSION', frog_protocols_version)

pkg_install_dir = join_paths(get_option('datadir'), 'pkgconfig')
configure_file(
	input: 'frog-protocols.pc.in',
	output: 'frog-protocols.pc',
	configuration: pkgconfig_configuration,
	install_dir: pkg_install_dir,
)

configure_file(
	input: 'frog-protocols-uninstalled.pc.in',
	output: 'frog-protocols-uninstalled.pc',
	configuration: pkgconfig_configuration,
)

frog_protocols = declare_dependency(
	variables: {
		'pkgdatadir': frog_protocols_srcdir,
	},
)

meson.override_dependency('frog-protocols', frog_protocols)
