/**
 * 
 */
package com.ystech.core.lucene.service;

import java.io.File;
import java.io.StringReader;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.io.FileUtils;
import org.apache.lucene.analysis.Analyzer;
import org.apache.lucene.analysis.TokenStream;
import org.apache.lucene.document.Document;
import org.apache.lucene.document.Field;
import org.apache.lucene.index.IndexReader;
import org.apache.lucene.index.IndexWriter;
import org.apache.lucene.index.IndexWriterConfig;
import org.apache.lucene.queryparser.classic.MultiFieldQueryParser;
import org.apache.lucene.search.BooleanClause;
import org.apache.lucene.search.Filter;
import org.apache.lucene.search.IndexSearcher;
import org.apache.lucene.search.Query;
import org.apache.lucene.search.ScoreDoc;
import org.apache.lucene.search.TopDocs;
import org.apache.lucene.search.highlight.Highlighter;
import org.apache.lucene.search.highlight.QueryScorer;
import org.apache.lucene.search.highlight.SimpleFragmenter;
import org.apache.lucene.search.highlight.SimpleHTMLFormatter;
import org.apache.lucene.store.Directory;
import org.apache.lucene.store.FSDirectory;
import org.apache.lucene.util.Version;
import org.springframework.stereotype.Component;
import org.wltea.analyzer.lucene.IKAnalyzer;

import com.ystech.core.util.PathUtil;
import com.ystech.cqgtdag.model.news.News;
import com.ystech.cqgtdag.service.news.NewsManageImpl;

/**
 * @author shusanzhan
 * @date 2013-11-4
 */
@Component("indexManageImpl")
public class IndexManageImpl {
	private final String INDEXPATH = "D:\\index";
	private NewsManageImpl newsManageImpl;
	@Resource
	public void setNewsManageImpl(NewsManageImpl newsManageImpl) {
		this.newsManageImpl = newsManageImpl;
	}
	public static String  getIndexPaht() {
		String path = PathUtil.getWebRootPath()	+ System.getProperty("file.separator") + 
				"archives"+ System.getProperty("file.separator")+
				"index";
		return path;
	}
	public boolean createIndex()  
    {  
		String filePath=null;
        //检查索引是否存在  
        if(this.isIndexExisted()==true){
        	 filePath = getIndexPaht();
        }else{
        	return false;
        }
        List<News> news = newsManageImpl.getAll();  
        try  
        {  
        	File file=new File(filePath);
            Directory directory = FSDirectory.open(file);
            
            Analyzer analyzer = new IKAnalyzer();
            
            IndexWriterConfig config = new IndexWriterConfig(Version.LUCENE_45,	analyzer);
            
            IndexWriter indexWriter =new IndexWriter(directory, config);
              
            long begin = new Date().getTime();  
            for(News ne: news)  
            {  
                Document doc = new Document();  
                doc.add(new Field("dbid", ne.getDbid()+"", Field.Store.YES, Field.Index.ANALYZED, Field.TermVector.YES));  
                String title = ne.getTitle() == null ? "" : ne.getTitle().trim();  
                doc.add(new Field("title", title, Field.Store.YES, Field.Index.ANALYZED, Field.TermVector.YES));  
                String content = ne.getContentText() == null ? "" : ne.getContentText();  
                doc.add(new Field("contentText", content, Field.Store.YES, Field.Index.ANALYZED, Field.TermVector.YES));  
                indexWriter.addDocument(doc);  
            }  
            long end = new Date().getTime();  
            System.out.println(">>> 1.存入索引完毕.. 共花费：" + (end - begin) +"毫秒...");  
              
            indexWriter.close();  
            return true;  
              
        }catch(Exception e){  
            e.printStackTrace();  
            return false;  
        }
    }  
	
	/**
	 * check Index is Existed
	 * @return true or false
	 */
	private boolean isIndexExisted() {
		try {
			String indexPaht = getIndexPaht();
			File dir = new File(indexPaht);
			if (null!=dir.listFiles()&&dir.listFiles().length > 0){
				File[] listFiles = dir.listFiles();
				for (File file : listFiles) {
					file.delete();
				}
				return true;
			}
			if(!dir.exists()){
				FileUtils.forceMkdir(dir);
				return true;
			}

		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		return false;
	}
	public Map<String, Object> getNews(String query,int pageSize,int currentPage) {  
        Map<String, Object> map=new HashMap<String, Object>();
        try{  
        List<News> qlist = new ArrayList<News>();  
        
        File file=new File(getIndexPaht());
        Directory directory = FSDirectory.open(file);
        
        IndexReader indexReader=IndexReader.open(directory);
        
        IndexSearcher indexSearcher = new IndexSearcher(indexReader);  
          
        //QueryParser parser = new QueryParser(fieldName, analyzer); //单 key 搜索  
        //Query queryOBJ = parser.parse(query);  
        System.out.println(">>> 2.开始读取索引... ... 通过关键字：【 "+ query +" 】");  
        long begin = new Date().getTime();  
          
        //下面的是进行title,content 两个范围内进行收索.  
        BooleanClause.Occur[] clauses = { BooleanClause.Occur.SHOULD,BooleanClause.Occur.SHOULD };
        
        Analyzer analyzer = new IKAnalyzer();
        
       /*QueryParser parser = new QueryParser(Version.LUCENE_CURRENT, "title",
				analyzer);
        
        parser.setDefaultOperator(QueryParser.AND_OPERATOR);


        Query queryLu = parser.parse(query);
		
        TopDocs topDocs = indexSearcher.search(queryLu, 5);*/
        
        
        Query queryOBJ = MultiFieldQueryParser.parse(Version.LUCENE_45,query, new String[]{"title","contentText"}, clauses, analyzer);//parser.parse(query);
        
        Filter filter = null;  
          
        //################# 搜索相似度最高的记录 ###################  
        //TopDocs topDocs = indexSearcher.search(queryOBJ, filter, 1000);  
        TopDocs topDocs = indexSearcher.search(queryOBJ , 10000);  
        System.out.println("*** 共匹配：" + topDocs.totalHits + "个 ***");  
          
        News article = null;  
          
        ScoreDoc[] scoreDocs = topDocs.scoreDocs;
        
      //查询起始记录位置
        int beginIndex = pageSize * (currentPage - 1) ;
        //查询终止记录位置
        int endIndex = Math.min(beginIndex + pageSize, scoreDocs.length);
        
        //输出结果  
        for (int i=beginIndex;i<endIndex;i++){  
				ScoreDoc scoreDoc = scoreDocs[i];
                Document targetDoc = indexSearcher.doc(scoreDoc.doc);  
                article = new News();  
                  
                //设置高亮显示格式  
                SimpleHTMLFormatter simpleHTMLFormatter = new SimpleHTMLFormatter("<font color='red'><strong>", "</strong></font>");   
                /* 语法高亮显示设置 */  
               Highlighter highlighter = new Highlighter(simpleHTMLFormatter,new QueryScorer(queryOBJ));  
                
                
                highlighter.setTextFragmenter(new SimpleFragmenter(200));   
                  
                // 设置高亮 设置 title,content 字段  
                String dbid = targetDoc.get("dbid");  
                
                String title = targetDoc.get("title");  
                String content = targetDoc.get("contentText");  
                TokenStream titleTokenStream = new IKAnalyzer().tokenStream("title",new StringReader(title));  
                TokenStream contentTokenStream = new IKAnalyzer().tokenStream("contentText",new StringReader(content));  
                
                String highLightTitle = highlighter.getBestFragment(titleTokenStream, title);
                
                String highLightContent = highlighter.getBestFragment(contentTokenStream, content);  
                  
                 if(highLightTitle == null)  
                     highLightTitle = title;  
  
                 if(highLightContent == null)   
                     highLightContent = content;
                if(null!=dbid){
                	article.setDbid(Integer.parseInt(dbid)); 
                }
                article.setTitle(highLightTitle);  
                article.setContentText(highLightContent);  
                qlist.add(article);  
        }  
          
        long end = new Date().getTime(); 
        System.out.println(">>> 3.搜索完毕... ... 共花费：" + (end - begin) +"毫秒...");  
        map.put("length", (Integer)topDocs.totalHits);
        map.put("result", qlist);
        indexReader.close();
        
        return map;  
          
        }catch(Exception e){  
            e.printStackTrace();  
            return null;  
        }  
    }  
}
