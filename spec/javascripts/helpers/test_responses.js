var TestResponses = {
  single_use_link: {
    success: {
      status: 200,
      responseText: "http://test.host/single_use_linkabc123"
    }
  },
  relationships_table: {
    query_url_success: {
        id: "parent5678",
        title: ["Parent"]
    },
    ajax_add_success:{},
    ajax_remove_success:{},
    ajax_error: {
      responseText: "Error"
    },
  }
}
