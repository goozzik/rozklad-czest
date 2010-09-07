Ext.setup({
  tabletStartupScreen: 'tablet_startup.png',
  phoneStartupScreen: 'phone_startup.png',
  icon: 'icon.png',
  glossOnIcon: false,
  onReady: function() {  

      var submitSearch = function() {
        schedule.submit({
          url: 'search'
        });
        schedule.removeAll();
        Ext.Ajax.request({
          url: 'search',
          success: function(response){
            schedule.update(response.responseText);
            shcedule.doLayout();
          }
        });
      }

      var schedule = new Ext.form.FormPanel({
        title: 'Połączenie',
        dockedItems: [{
          xtype: 'toolbar',
          dock: 'top',
          ui: 'light',
          items: [{
            text: 'Szukaj',
            ui: 'round',
            handler: submitSearch
          }]
        }],
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
        }
      });
  }
});
