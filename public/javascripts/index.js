Ext.setup({
  glossOnIcon: false,
  tabletStartupScreen: 'tablet_startup.png',
  phoneStartupScreen: 'phone_startup.png',
  icon: 'icon.png',
  onReady: function(){

    var schedule = new Ext.form.FormPanel({
      scroll: 'vertical',
      title: 'Połączenie',
      standardSubmit: true,
      url: 'search_schedule',
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
            name: 'from',
            label: 'Do',
            options: availableStations
          }
        ]
      }],
      dockedItems: [{
        xtype: 'toolbar',
        dock: 'top',
        items: {
          text: 'Szukaj',
          handler: function() {
            schedule.submit();
          } 
        }  
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
      animation: 'slide',
      cardAnimation: 'slide',
      items: [schedule]  
    })
  }
});
