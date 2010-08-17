Ext.setup({
  glossOnIcon: false,
  tabletStartupScreen: 'tablet_startup.png',
  phoneStartupScreen: 'phone_startup.png',
  icon: 'icon.png',
  onReady: function(){
     
 
    var contact = new Ext.Component({
      title: 'Kontakt',
      cls: 'contact',
    });

    var schedule = new Ext.form.FormPanel({
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
      scroll: 'vertical',
      animation: 'slide',
      cardAnimation: 'slide',
      items: [schedule, contact],
      dockedItems: [{
        xtype: 'toolbar',
        dock: 'top'
      }]
    })
  }
});
