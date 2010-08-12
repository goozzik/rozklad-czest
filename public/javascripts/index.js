Ext.setup({
  glossOnIcon: false,
  onReady: function() {
    var timeline = new Ext.Component({
        title: 'Timeline',  // Name that appears on this tab
        cls: 'timeline',    // The CSS class. Lets you style elements on the timeline.
        scroll: 'vertical', // Make it vertically scrollable
    });
    
    var schedule = new Ext.form.FormPanel({
      title: 'Polaczenie',
      scroll: 'vertical',
      xtype: 'fieldset',
      items: [{
        xtype: 'textfield',
        name: 'from', 
        label: 'Z',
        id: 'from_search'
      },
      {
        xtype: 'textfield',
        name: 'to',
        id: 'to_search',
        label: 'Do'
      }
      ]
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
      items: [timeline, schedule]  
    });
  }
});
