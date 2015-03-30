<?php include '00header.php'; ?>  
        <div id="page-wrapper">
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">SQL - Select</h1>
                </div>
                <div class="col-lg-6">
                    <label>SQL Query (Only Select)</label>
                    <textarea class="form-control" onfocus id="sql_select" rows="5" name="sql_select"></textarea><br>
                    <a id="btnSql_select" class="btn btn-primary"> Ejecutar</a>                                        
                </div>                
                <div class="col-lg-12">
                    <!--pre>                    
                    </pre-->
                    <div class="col-lg-12">
                        <img id="img" src="../img/loading.gif" alt="loading" title="loading" style="margin: 0 auto;">
                    </div>
                    <label id="msg_sql"></label>
                    <div class="panel-body table-responsive">
                        <div class="dataTable_wrapper">
                            <table id="tbl" class="table table-striped table-bordered table-hover" >
                                <thead></thead>
                                <tbody></tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row" style="text-align: center">
                
            </div>
            
        </div>
        <!-- /#page-wrapper -->

<?php include '00footer.php'; ?>
