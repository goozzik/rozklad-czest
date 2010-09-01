Ext.setup({
    glossOnIcon: false,
    onReady: function() {
	
			var schedule = new Ext.form.FormPanel({
				title: 'Połączenie',
				items: [{
					xtype: 'fieldset',
					title: 'Wyszukaj połączenie',
					items: [{
						xtype: 'select',
						name: 'from',
						label: 'Z',
						options: availableStations
					},
					{
					 	xtype: 'select',
						name: 'to',
						label: 'Do',
						options: availableStations
					}]
				}]
			});
		
			var panel = new Ext.TabPanel({
				tabBar: {
					dock: 'bottom',
					ui: 'light',
					layout: {
						pack: 'center'
					}
				},
				fullscreen: true,
				ui: 'light',
				items: [schedule],
				defaults: {
				        scroll: 'vertical'
				},
				animation: {
				        type: 'slide',
				        cover: true,
				},
			});
		}
});